package com.applanga.debug

import org.gradle.api.DefaultTask
import org.gradle.api.tasks.TaskAction

import org.gradle.api.Project


abstract class ApplangaDebugTask : DefaultTask() {

    companion object {
        fun apply(project: Project) {
        }
    }

    @TaskAction
    fun taskAction() {
    }
}