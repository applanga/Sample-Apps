import org.gradle.kotlin.dsl.`kotlin-dsl`
plugins {
    `kotlin-dsl`
    `java-gradle-plugin`
}

repositories {
    mavenCentral()
    google()
}

dependencies {
    implementation(kotlin("stdlib"))
    implementation(kotlin("script-runtime"))
    implementation(kotlin("reflect"))
    implementation("com.android.tools.build:gradle-api:7.3.1")
    //implementation("com.android.tools.build:gradle:7.2.1")
}