MostPublishedBooks

**Overview**

This repository contains a Salesforce implementation for a schedulable Apex class that makes a callout to an external endpoint and a Lightning Web Component (LWC) that subscribes to a platform event and displays the results.

**Features**

Schedulable Apex Class: Makes a callout to https://eoheai3ashoyzos.m.pipedream.net to fetch book data.

Platform Event: Publishes MostPublishedBooks__e containing a sorted list of books where the edition size exceeds 600,000 copies.

Lightning Web Component (LWC): Subscribes to MostPublishedBooks__e using lightning/empApi and displays the book list in a user-friendly format.

Unit Tests: Covers the most critical functionality for Apex and LWC components.

Deployment Instructions: Guide to deploy the solution in a Salesforce Scratch Org.

End-to-End Testing: Instructions for testing the functionality within a Scratch Org.

**Installation & Deployment**

Prerequisites

Ensure you have the following installed:

Salesforce CLI

A Salesforce Dev Hub with Scratch Org enabled

Node.js & npm (for LWC development)

**Steps**

1. Authenticate Dev Hub

sf org login web --set-default-dev-hub --alias DevHub

2. Clone the Repository

git clone https://github.com/SurbhiB62/MostPublishedBooks.git
cd MostPublishedBooks

3. Activate DevHub as default

sf config set target-org=Devorg 

4. Create a Scratch Org

sf org create scratch --definition-file config/project-scratch-def.json --set-default --alias BillieScratchOrg

5. Validate the scratch org is created and is currently active and set as default
   sf org list --all
6. Push Source Code to Scratch Org

sf project deploy start --target-org BillieScratchOrg


Post Deployment Steps:

1.Open the Scratch Org
sf org open --target-org ScratchOrg

2.Go to logged in user record and perform below steps:
   
   
   a.Assign permission set "Integration Permission" to the user
   b.Search for Publish Book Result in the app manager in the setup and edit it to assign system administrator profile to it



3.Schedule the Apex Class
Navigate to Setup > Apex Classes
Schedule the class MostPublishedBooksScheduler for execution




**Manual Testing Steps**

1. Open the app Publish Book Result from the app launcher
2. Execute the below script in the anonymous window of the developer console
   PublishedBooksHandler.getPublishedBooksDetails();
3.Verify expected results in the app which was opened in step 1
