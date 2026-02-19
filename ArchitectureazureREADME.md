Architecture Cloud Azure with AKS

1. Client Apps
Client applications represent end users (web, mobile, desktop apps).
They send HTTP/HTTPS requests to the Azure infrastructure.
Example: A mobile e-commerce app sends a request to retrieve a product catalog.
2. Azure Load Balancer & Public IP
The Load Balancer distributes incoming traffic across multiple instances to prevent overload.
The Public IP enables internet access.
Key features:
- High availability
- Automatic traffic distribution
- Layer 4 (TCP/UDP) support
Example: If 10,000 users access the website, the Load Balancer distributes requests across multiple pods.
3. Azure Kubernetes Service (AKS)
AKS is a managed Kubernetes service that orchestrates containers.
It manages:
- Auto-scaling (HPA)
- Node management
- Cluster upgrades
Example: If CPU usage exceeds 70%, AKS can automatically create new pods.
4. Ingress Controller (NGINX)
Ingress manages HTTP/HTTPS routing to internal services.
Functions:
- SSL termination
- URL-based routing
- Certificate management
Example: /api → backend microservice, / → frontend.
5. Microservices Architecture

Microservices architecture is a software architectural style where an application is composed of multiple independent, loosely coupled services, each responsible for a specific business capability. Each microservice is independent and containerized.

Advantages:
- Independent scaling
- Resilience
- Independent deployment

Example: microservice1 = authentication
microservice2 = order management
microservice3 = payment
6. Azure Container Registry (ACR)
It is a managed Kubernetes service used to orchestrate containers, manage auto-scaling, and simplify cluster management. ACR stores Docker images.
Process:
1. CI/CD builds the image
2. Push to ACR
3. AKS pulls the image
Example: image:v1.0 automatically deployed after pipeline validation.
7. Azure Pipelines (CI/CD) & Helm
Azure pipeline (CI/CD) is a DevOps service enabling Continuous Integration (CI) and Continuous Deployment (CD).
CI/CD automates:
- Build
- Test
- Deployment

Helm simplifies deployment using templates (charts).
Example: helm upgrade --install updates an application.

8. Networking (Azure CNI + VNet)
Azure CNI assigns VNet IP addresses to pods.
Cilium adds network security (Network Policies).

Benefits:
- Secure communication
- Network isolation
- Traffic monitoring
9. Security (Managed Identities, RBAC, Entra ID, Key Vault)
Managed Identity allows a pod to access Key Vault without passwords.
RBAC controls permissions.
Entra ID manages identities.
Key Vault stores secrets and certificates.

Example: A microservice retrieves an API key from Key Vault using Managed Identity.
10. Monitoring (Azure Monitor, Log Analytics, Application Insights)
Azure Monitor centralizes metrics and alerts.
Log Analytics analyzes logs.
Application Insights monitors application performance.

Example: Alert triggered if response time > 2 seconds.

11. External Data Stores (Cosmos DB, Redis, Service Bus)
Cosmos DB: Globally distributed NoSQL database.
Redis: In-memory cache to speed up queries.
Service Bus: Asynchronous communication between microservices.
Example:
- Product query → Cosmos DB
- Popular cache → Redis
- Payment validated → message sent via Service Bus
12.  Docker 
 Docker is an open-source containerization platform that uses OS-level virtualization to run applications in isolated environments called containers.
Example : A Docker container:
•	Shares the host OS kernel
•	Runs as an isolated process
•	Is created from an immutable Docker image
•	Is stateless by default
