moqui starter project

This project will checkout moqui framework and component as subproject.
provide Jenkinsfile for an example of using Jenkins CI. It also contains a sample myaddons.xml file
which will be copy to moqui project. You can customize component information as you like.

Usage
```
	./gradlew getComponent -Pcomponent=example
	./gradlew load
```
