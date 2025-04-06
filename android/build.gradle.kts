buildscript {
    dependencies {
        classpath 'com.android.tools.build:gradle:8.2.0'
        classpath 'com.google.gms:google-services:4.3.15' // Required for Firebase
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Optional custom build dir (you already had this)
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
