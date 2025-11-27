# Contributing to VRMS (Volunteer Resource Management System)

Thank you for your interest in contributing to the Volunteer Resource Management System!

VRMS is built using a **microservices architecture**, and this repository is the **meta-repository** that aggregates all services using **Git submodules**.

Please read this guide carefully before contributing.

---

## Repository Structure

This repository contains the main platform structure and includes several **submodules**:

```
VRMS/
├── user-service/
├── ngo-posting-service/
├── matching-service/
├── analytics-service/
├── frontend/
├── docker-compose.yml
├── CONTRIBUTING.md
└── README.md
```

Each folder above is a **submodule**, pointing to its own independent repository.

---

## Cloning the Project (IMPORTANT)

To correctly clone the VRMS meta-repo with all microservices:

```bash
git clone --recurse-submodules https://github.com/udaysingh21/Volunteer-Resource-Management-System.git
cd Volunteer-Resource-Management-System
```

If you cloned without submodules, run:

```bash
git submodule update --init --recursive
```

## Forking the Project

- Click on the Fork button of the top right corner
- Give the repository name and discription
- Start your own OSS!

---

## Where Should I Contribute?

VRMS consists of multiple independent services. Please make sure you contribute in the **correct repository**.

### Examples:

| Task | Repository |
|------|------------|
| Fix login or user profile | [user-service](https://github.com/udaysingh21/User-Service) |
| Fix NGO project posting | [ngo-posting-service](https://github.com/udaysingh21/NGO-Postings-Service) |
| Improve matching algorithm | [matching-service](https://github.com/udaysingh21/Matching-Service) |
| Add analytics charts | [analytics-service](https://github.com/udaysingh21/Analytics-Service) |
| Fix UI / frontend bug | [frontend](https://github.com/udaysingh21/VRMS_Frontend) |
| Update project docs or orchestration | [VRMS](https://github.com/udaysingh21/VRMS_Frontend) (this repo) |

---

## Development Workflow

### 1. Navigate to the microservice you want to work on

```bash
cd user-service
```

### 2. Create a new branch

```bash
git checkout -b feature/my-new-feature
```

### 3. Make your changes and commit

```bash
git add .
git commit -m "Add my new feature"
```

### 4. Push your branch

```bash
git push origin feature/my-new-feature
```

### 5. Open a Pull Request

Open a Pull Request in the **microservice's own GitHub repo**, not the VRMS repo.

---

## Updating Submodules After a PR Is Merged

Once your PR is merged into a microservice repo:

### 1. Pull the latest updates from that microservice

```bash
cd user-service
git pull origin main
```

### 2. Go back to VRMS root

```bash
cd ..
```

### 3. Stage and commit the updated submodule pointer

```bash
git add user-service
git commit -m "Update user-service submodule pointer"
git push
```

This tells VRMS which commit of each microservice it's currently using.

---

## Checking for Submodule Updates

To pull the latest versions of all submodules:

```bash
git submodule update --remote --merge
```

---

## Running the Platform (Docker)

You can run the entire system using Docker:

```bash
docker-compose up --build
```

This starts all services together.

To stop the services:

```bash
docker-compose down
```

---

## Code Quality Guidelines

Please follow these guidelines when contributing:

-  Follow the coding style already used in each microservice
-  Write clear, modular, maintainable code
-  Include documentation and comments where necessary
-  Add tests if the microservice uses automated testing
-  Avoid putting microservice-specific logic in this meta-repo
-  Ensure your code passes all existing tests before submitting
-  Update documentation if you change functionality

---

## Reporting Issues

Please open issues in the **correct service repository**.

### Examples:

- Backend user issues → [user-service](https://github.com/udaysingh21/User-Service/issues)
- Backend NGO Posting  issues → [user-service](https://github.com/udaysingh21/User-Service/issues)
- Matching issues → [matching-service](https://github.com/udaysingh21/Matching-Service/issues)
- Frontend UI bugs → [frontend](https://github.com/udaysingh21/VRMS_Frontend/issues)
- Docs or deployment issues → [VRMS](https://github.com/udaysingh21/Volunteer-Resource-Management-System/issues) (this repo)

This helps maintainers respond faster.

---

## Discussions

If you're not sure where something belongs:

- Open a discussion in the [VRMS meta-repo discussions](https://github.com/udaysingh21/Volunteer-Resource-Management-System/discussions)

---

## Pull Request Checklist

Before submitting your PR, make sure:

- [ ] Code follows the project's style guidelines
- [ ] All tests pass
- [ ] Documentation is updated (if needed)
- [ ] Commit messages are clear and descriptive
- [ ] PR description explains what changed and why
- [ ] You've linked any related issues

---

## First Time Contributors

New to open source? Welcome! Here are some good first issues to get started:

- Look for issues labeled `good first issue` in any microservice repo
- Check the documentation for typos or unclear sections
- Improve test coverage
- Add code comments to complex functions

---

## Code of Conduct

Please note that this project adheres to a Code of Conduct. By participating, you are expected to uphold this code. Please report unacceptable behavior to the project maintainers.

---

## Thank You

Your contributions help build a platform that empowers volunteers, NGOs, and communities globally. We appreciate your time, effort, and support!

**Happy Contributing! 🎉**
