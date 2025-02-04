# Take-Home Assignment: Salesforce Apex & LWC

## Overview
This project is a Salesforce implementation that includes:

- A **Schedulable Apex Class** that makes a callout to an external endpoint.
- A **Lightning Web Component (LWC)** that subscribes to a Platform Event and displays the result in a user-friendly format.

## Assignment Details

### Features Implemented:
1. **Schedulable Apex Class**
   - Calls the endpoint: `https://eoheai3ashoyzos.m.pipedream.net`.
   - Retrieves a list of books.
   - Publishes a **MostPublishedBooks__e** platform event containing books sorted by edition size (descending), where edition size exceeds **600,000 copies**.

2. **Lightning Web Component (LWC)**
   - Subscribes to the **MostPublishedBooks__e** event using `lightning/empApi`.
   - Displays the list of books in a structured and user-friendly format.

3. **Unit Testing**
   - Includes test cases for the core functionality.
   - Ensures Apex callouts and event publishing work correctly.

## Deployment Instructions

### Prerequisites
- Salesforce CLI installed
- A Salesforce Developer Hub (Dev Hub) enabled org
- Node.js (for any additional setup if required)

### Steps to Deploy to a Scratch Org
1. **Clone the repository**:
   ```sh
   git clone <repository-url>
   cd <repository-folder>
   ```
2. **Authenticate with Salesforce**:
   ```sh
   sf login org
   ```
3. **Create a Scratch Org**:
   ```sh
   sf org create scratch --duration-days 7 --set-default
   ```
4. **Push Source Code to Scratch Org**:
   ```sh
   sf project deploy start
   ```
5. **Assign Permissions (if required)**:
   ```sh
   sf org assign permset -n <Permission_Set_Name>
   ```
6. **Open Scratch Org**:
   ```sh
   sf org open
   ```
7. **Run Apex Tests**:
   ```sh
   sf apex run test --result-format human --code-coverage
   ```

## End-to-End Testing

1. **Trigger the Schedulable Apex Job**:
   - Manually schedule it using the Developer Console or Apex Scheduler.

2. **Verify Platform Event Publishing**:
   - Use `Workbench` or `Developer Console` to confirm the **MostPublishedBooks__e** event is published.

3. **Check LWC UI**:
   - Open the Salesforce app page containing the LWC and verify book data is displayed correctly.

## Repository Structure
```
|-- force-app/
|   |-- main/
|       |-- default/
|           |-- classes/  # Apex classes
|           |-- lwc/      # Lightning Web Components
|           |-- objects/  # Custom Objects & Events
|-- tests/  # Test cases
|-- README.md
```
