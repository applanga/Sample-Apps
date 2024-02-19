package com.applanga.debug

import com.android.build.api.dsl.AndroidSourceSet
import com.android.build.api.dsl.ApplicationExtension
import org.gradle.api.DefaultTask
import org.gradle.api.tasks.TaskAction

import com.android.build.api.variant.AndroidComponentsExtension
import com.android.build.api.variant.Variant
import org.gradle.api.Project


abstract class ApplangaDebugTask : DefaultTask() {

    companion object {
        fun apply(project: Project) {
            println("Hello \"${project.parent?.name}\" from task!")
            val androidComponents =
                project.extensions.getByType(AndroidComponentsExtension::class.java)
            println(androidComponents)
            androidComponents.onVariants { variant ->
                println("OnVariant: " + variant.name);

                val resourceSourceSets: MutableList<AndroidSourceSet> =
                    mutableListOf()

                val androidExtension =
                    project.extensions.getByType(ApplicationExtension::class.java)

                println("androidExtension: $androidExtension")

                androidExtension.sourceSets.forEach { srcSet ->
                    println("srcSet: ${srcSet.name} type: ${srcSet.javaClass}")
                }

                val mainSourceSet = "main"
                resourceSourceSets.add(androidExtension.sourceSets.getByName(mainSourceSet))
                val flavorSourceSet = variant.flavorName // e.g. "dev"
                if (flavorSourceSet != null && flavorSourceSet.isNotEmpty()) {
                    resourceSourceSets.add(androidExtension.sourceSets.getByName(flavorSourceSet))
                }
                val buildTypeSourceSet = variant.buildType // e.g. "debug"
                if (buildTypeSourceSet != null) {
                    resourceSourceSets.add(
                        androidExtension.sourceSets.getByName(
                            buildTypeSourceSet
                        )
                    )
                }
                if (flavorSourceSet != null && flavorSourceSet.isNotEmpty() && buildTypeSourceSet != null) {
                    val buildVariantSourceSet =
                        "$flavorSourceSet${buildTypeSourceSet.capitalize()}" // e.g. "devDebug"
                    resourceSourceSets.add(
                        androidExtension.sourceSets.getByName(
                            buildVariantSourceSet
                        )
                    )
                }

                println("print resource set for variant: ${variant.name}")
                println("resourceSourceSets length: ${resourceSourceSets.size}")
                resourceSourceSets.forEach { srcSet ->
                    println("---> srcSet start: ${srcSet.name}")
                    println(srcSet.res.srcDirs().javaClass)
                    val srcDirs = srcSet.res.srcDirs()
                    srcDirs::class.members.firstOrNull { it.name == "srcDirs" }?.let {
                        println(it.call(srcDirs))
                    }
                    println("<--- srcSet end: ${srcSet.name}")
                }
            }
        }
    }

    @TaskAction
    fun taskAction() {
        println("Hello \"${project.parent?.name}\" from task!")


    }
}