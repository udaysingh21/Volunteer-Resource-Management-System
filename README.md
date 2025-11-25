# Volunteer Resource Management System (VRMS)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

VRMS is an open-source platform designed to connect volunteers, NGOs, and corporate organizations. The system follows a microservices architecture, with each service maintained as its own independent repository.

This repository is the meta-repository, which contains:
- All services added as Git submodules
- Deployment configurations (Docker Compose / Kubernetes)
- Documentation and architecture
- Contribution workflow
- References to each microservice

---

## Repository Structure

When cloned with submodules, your folder will look like this:

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

Each directory is a Git submodule, pointing to its own repository.

---

## Getting Started

### Clone the VRMS Platform (Important: include submodules)

```bash
git clone --recurse-submodules https://github.com/udaysingh21/Volunteer-Resource-Management-System
cd VRMS
```

If you accidentally cloned without submodules:

```bash
git submodule update --init --recursive
```

---

## Microservices Included

Every submodule is an independent MIT-licensed repository:

| Service | Description | Repo Link |
|---------|-------------|-----------|
| **User Service** | Manages authentication, users, profiles | [user-service](https://github.com/udaysingh21/User-Service) |
| **NGO Posting Service** | NGO listings, requests, project postings | [ngo-posting-service](https://github.com/udaysingh21/NGO-Postings-Service) |
| **Matching Service** | Matches volunteers ↔ NGO needs | [matching-service](https://github.com/udaysingh21/Matching-Service) |
| **Analytics Service** | Reporting, dashboards, insights | [analytics-service](https://github.com/udaysingh21/Analytics-Service) |
| **Frontend** | Web UI for the platform | [frontend](https://github.com/udaysingh21/VRMS_Frontend) |

---

## Run the Entire Platform (Docker Compose)

Make sure Docker & Docker Compose are installed.

Then run:

```bash
docker-compose up --build
```

This will start:
- All backend microservices
- Frontend UI
- Shared databases (if configured)

To stop:

```bash
docker-compose down
```

---

## Updating Submodules

When a microservice repository is updated, run:

```bash
git submodule update --remote --merge
```

Or manually update one service:

```bash
cd user-service
git pull origin main
cd ..
git add user-service
git commit -m "Update user-service submodule pointer"
git push
```

---

## Adding a New Submodule

Use this command inside the VRMS root:

```bash
git submodule add https://github.com/YOUR_ORG/REPO_NAME.git folder-name
```

Then commit:

```bash
git add .gitmodules folder-name
git commit -m "Add new microservice submodule"
git push
```

---

## Contributing

We welcome contributions from developers, NGOs, students, and open-source contributors.

Please follow these steps:
1. Clone with submodules
2. Make changes inside the microservice repo folder
3. Open pull requests in that microservice's repo
4. After merge, update the submodule pointer in VRMS

See [CONTRIBUTING.md](CONTRIBUTING.md) for the full workflow.

---

## Reporting Issues

Please report issues in the correct microservice repository.

**Examples:**
- User login bug → [user-service](https://github.com/udaysingh21/User-Service)
- NGO form not saving → [ngo-posting-service](https://github.com/udaysingh21/NGO-Postings-Service)
- Matching logic incorrect → [matching-service](https://github.com/udaysingh21/Matching-Service)
- Analytics logic incorrect → [analytics-service](https://github.com/udaysingh21/Analytics-Service)
- UI issue → [frontend](https://github.com/udaysingh21/VRMS_Frontend)
- Deployment or orchestration issue → [VRMS meta-repo](https://github.com/udaysingh21/VRMS_Frontend)


---

## License

This project is open-source under the [MIT License](LICENSE).

Each submodule also contains its own MIT license.

---

## Acknowledgements

Thanks to all contributors helping build technology that empowers volunteers, NGOs, and communities worldwide.

---

## Contact

For questions or collaboration opportunities, please open an issue or reach out to the maintainers.

**Happy Contributing! 🎉**
