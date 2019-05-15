node {
  def acr = 'newrejestr2018.azurecr.io'
  def appName = 'apka'
  def imageName = "${acr}/${appName}"
  def imageTag = "${imageName}:${env.BRANCH_NAME}.${env.BUILD_NUMBER}"
  def appRepo = "newrejestr2018.azurecr.io/apka:1"

  checkout scm
  
 stage('Build the Image and Push to Azure Container Registry') 
 {
   app = docker.build("${imageName}")
   withDockerRegistry([credentialsId: 'az-auth', url: "https://${acr}"]) {
      app.push("${env.BRANCH_NAME}.${env.BUILD_NUMBER}")
                }
  }

 stage ("Deploy Application on Azure Kubernetes Service")
 {
  switch (env.BRANCH_NAME) {
    // Roll out to canary environment
    case "canary":
        // Change deployed image in canary to the one we just built
        sh("sed -i.bak 's#${appRepo}#${imageTag}#' ./k8s/canary/*.yaml")
        sh("kubectl --namespace=prod apply -f k8s/canary/*.yaml")
        sh("echo http://kubectl --namespace=prod get service/${appName} --output=json | jq -r '.status.loadBalancer.ingress[0].ip' > ${appName}")
        break

    // Roll out to production
    case "master":
        // Change deployed image in master to the one we just built
        sh("sudo sed -i.bak 's#${appRepo}#${imageTag}#' ./k8s/production/*.yaml")
        sh("sudo kubectl --namespace=prod apply -f k8s/production/*.yaml")
        sh("sudo echo http://kubectl --namespace=prod get service/${appName} --output=json | jq -r '.status.loadBalancer.ingress[0].ip' > ${appName}")
        break

    // Roll out a dev environment
    default:
        // Create namespace if it doesn't exist
        sh("kubectl get ns ${appName}-${env.BRANCH_NAME} || kubectl create ns ${appName}-${env.BRANCH_NAME}")
        // Don't use public load balancing for development branches
        sh("sed -i.bak 's#${appRepo}#${imageTag}#' ./k8s/dev/*.yaml")
        sh("kubectl --namespace=${appName}-${env.BRANCH_NAME} apply -f k8s/dev/")
        echo 'To access your environment run kubectl proxy'
        echo "Then access your service via http://localhost:8001/api/v1/proxy/namespaces/${appName}-${env.BRANCH_NAME}/services/${appName}:80"     
    }
  }
}
