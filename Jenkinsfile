pipeline {
	agent any

	stages {

	    stage('git') {
	        steps {
	           script {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'git_creds', url: 'https://github.com/anurag4418/userlogin-docker.git']]])	              
	           }
	        }
	    }

	    stage('maven') {
	          steps {
	                script {
		                def mvnHome = tool name: 'maven3', type: 'maven'
		                sh "${mvnHome}/bin/mvn -version"
		                sh "${mvnHome}/bin/mvn -Dmaven.test.failure.ignore=true clean package"	                       
	                }
	          }
	    }

	    stage('sonar') {

	    	environment {
	    		scannerHome = tool 'sonar_scanner'
	    	}
	    	steps {
	    		withSonarQubeEnv('sonar_server') {
    				sh "${scannerHome}/bin/sonar-scanner"
				}
	    	}

	    }

	    stage('docker-build') {
	    	steps {
	    		script {

						sshPublisher(publishers: [sshPublisherDesc(configName: 'docker_host', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'docker build -t anuragjunghare/userlogin:${BUILD_NUMBER} .', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '//home//anurag_junghare', remoteDirectorySDF: false, removePrefix: '', sourceFiles: 'target/UserLogin.war,Dockerfile')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
	    		}
	    	}
	    }	    

	    stage('docker-run') {
	    	steps {
	    		script {
                        
                        sshPublisher(publishers: [sshPublisherDesc(configName: 'docker_host', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'docker rm -f my-web || true', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '//home//anurag_junghare', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
						sshPublisher(publishers: [sshPublisherDesc(configName: 'docker_host', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'docker run -d -p 8080:8080 --name my-web --link my-mysql  anuragjunghare/userlogin:${BUILD_NUMBER}', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '//home//anurag_junghare', remoteDirectorySDF: false, removePrefix: '', sourceFiles: 'target/UserLogin.war,Dockerfile')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])

	    		}
	    	}
	    }


	}
}