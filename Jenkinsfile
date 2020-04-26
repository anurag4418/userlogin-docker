pipeline {
	agent any

	stages {

	    stage('git') {
	        steps {
	           script {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'git_creds', url: 'https://github.com/anurag4418/userlogin.git']]])	              
	           }
	        }
	    }

	    stage('maven') {
	          steps {
	                script {
		                def mvnHome = tool name: 'maven3', type: 'maven'
		                sh "${mvnHome}/bin/mvn -version"
		                sh "${mvnHome}/bin/mvn -Dmaven.test.failure.ignore=true clean deploy"	                       
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

	    stage('deploy') {
	    	steps {
	    		script {

	    			sshPublisher(publishers: [sshPublisherDesc(configName: 'ansible_server', 
					transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'ansible-playbook /etc/ansible/copywarfile.yml', 
					execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', 
					remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
	    		}
	    	}
	    }
	}
}