# VRMS API Testing with Bruno

This collection contains comprehensive API tests for the **Volunteer Resource Management System (VRMS)** microservices architecture using [Bruno](https://www.usebruno.com/), an open-source API client.

## 🏗️ Architecture Overview

The VRMS system consists of 5 microservices accessible through an **API Gateway** (Nginx) on port `8085`:

| Service | Direct Port | Gateway Route | Description |
|---------|-------------|---------------|-------------|
| **User Service** | 8080 | `/users/*` | Authentication, user management |
| **NGO Postings** | 8082 | `/postings/*` | NGO posting CRUD operations |
| **Matching Service** | 8081 | `/match/*` | Volunteer-posting recommendations |
| **Analytics Service** | 8000 | `/analytics/*` | Admin dashboard analytics |
| **Frontend** | 5174 | `/` | React frontend application |

## 🚀 Getting Started

### Prerequisites

1. **Install Bruno**: Download from [usebruno.com](https://www.usebruno.com/)
2. **Start VRMS Services**: Ensure Docker Compose is running:
   ```bash
   cd /Users/I528928/Volunteer-Resource-Management-System
   docker compose up -d
   ```
3. **Verify Services**: Check all services are healthy:
   ```bash
   curl http://localhost:8085/users/actuator/health
   curl http://localhost:8085/postings/actuator/health
   curl http://localhost:8085/match/actuator/health
   curl http://localhost:8085/analytics/api/v1/admin/analytics/user-insights
   ```

### Import Collection

1. Open Bruno
2. Click "Import Collection"
3. Select the `bruno-tests` folder
4. Collection will be imported with all folders and requests

## 📁 Collection Structure

```
bruno-tests/
├── VRMS_API_Collection.bru          # Main collection config
├── 01_Auth/                         # Authentication endpoints
│   ├── 01_Register_Volunteer.bru
│   ├── 02_Register_NGO.bru
│   ├── 03_Register_Corporate.bru
│   ├── 04_Login_User.bru
│   └── 05_Login_NGO.bru
├── 02_User_Service/                 # User management APIs
│   ├── 01_Get_All_Volunteers.bru
│   ├── 02_Get_Volunteer_By_ID.bru
│   ├── 03_Get_All_NGOs.bru
│   ├── 04_Register_Volunteer_For_Posting.bru
│   └── 05_Get_Volunteer_Postings.bru
├── 03_NGO_Posting_Service/          # NGO posting management
│   ├── 01_Create_Posting.bru
│   ├── 02_Get_All_Postings.bru
│   ├── 03_Get_Posting_By_ID.bru
│   ├── 04_Get_Postings_By_NGO.bru
│   ├── 05_Get_Postings_By_Domain.bru
│   ├── 06_Update_Posting.bru
│   ├── 07_Register_Volunteer.bru
│   ├── 08_Get_Volunteers_For_Posting.bru
│   └── 09_Unregister_Volunteer.bru
├── 04_Matching_Service/             # Intelligent matching
│   ├── 01_Get_Recommended_Postings.bru
│   ├── 02_Get_Recommended_With_Date.bru
│   ├── 03_Register_Via_Matching.bru
│   └── 04_Unregister_Via_Matching.bru
├── 05_Analytics_Service/            # Dashboard analytics
│   ├── 01_Get_User_Insights.bru
│   └── 02_Get_Volunteers_Per_Posting.bru
└── 99_Cleanup/                      # Cleanup operations
    └── 01_Delete_Posting.bru
```

## 🧪 Testing Workflow

### Step 1: Authentication Flow
Run the authentication requests in order:

1. **Register Volunteer** - Creates a volunteer user
2. **Register NGO** - Creates an NGO user
3. **Register Corporate** - Creates a corporate user
4. **Login User** - Gets volunteer JWT token (auto-saved)
5. **Login NGO** - Gets NGO JWT token (auto-saved)

### Step 2: Core API Testing
With authentication tokens set, test the core functionality:

1. **User Service** - Test user management endpoints
2. **NGO Posting Service** - Test posting CRUD operations
3. **Matching Service** - Test volunteer-posting matching
4. **Analytics Service** - Test reporting endpoints

### Step 3: Integration Testing
Test cross-service functionality:
- Register volunteer for posting via User Service
- Register volunteer for posting via Matching Service
- View volunteer details from NGO perspective
- Check analytics after registrations

## 🔑 Environment Variables

The collection uses these environment variables (set automatically):

```javascript
base_url: http://localhost:8085
user_service_url: http://localhost:8085/users
ngo_service_url: http://localhost:8085/postings
matching_service_url: http://localhost:8085/match
analytics_service_url: http://localhost:8085/analytics

// Auth tokens (auto-populated after login)
volunteer_token: [JWT_TOKEN]
ngo_token: [JWT_TOKEN]
admin_token: [JWT_TOKEN]

// Sample IDs for testing
volunteer_id: 1
ngo_id: 2
posting_id: 1
```

## 📊 Sample Request Bodies

### Register Volunteer
```json
{
  "email": "john.volunteer@example.com",
  "password": "SecurePass123!",
  "name": "John Volunteer",
  "phone": "+1-234-567-8900",
  "address": "123 Main St, Anytown, USA",
  "role": "VOLUNTEER",
  "dob": "1995-05-15",
  "gender": "Male",
  "skills": ["Communication", "Event Management", "Teaching"],
  "interests": ["Education", "Environment", "Health"],
  "availability": "Weekends and evenings",
  "languages": ["English", "Spanish"]
}
```

### Register NGO
```json
{
  "email": "helpinghands@ngo.org",
  "password": "NGOSecure456!",
  "name": "Helping Hands Foundation",
  "phone": "+1-555-123-4567",
  "address": "456 Charity Lane, Goodville, USA",
  "role": "NGO",
  "registrationNumber": "NGO-2024-001",
  "foundedYear": 2018,
  "sector": "Education & Community Development",
  "websiteUrl": "https://www.helpinghands.org",
  "missionStatement": "Empowering communities through education, healthcare, and sustainable development programs.",
  "verificationStatus": "PENDING"
}
```

### Create NGO Posting
```json
{
  "title": "Community Garden Volunteer Program",
  "description": "Join us in creating a sustainable community garden...",
  "domain": "Environment",
  "location": "Green Valley Community Center",
  "city": "Greenville",
  "state": "California",
  "country": "USA",
  "pincode": "90210",
  "effortRequired": "Physical work, 4-6 hours per session",
  "volunteersNeeded": 15,
  "startDate": "2024-12-15",
  "endDate": "2025-03-15",
  "contactEmail": "garden@helpinghands.org",
  "contactPhone": "+1-555-GARDEN"
}
```

## 🔒 Security & Authorization

### JWT Token Management
- Tokens are automatically extracted and saved after successful login
- Each request uses appropriate token based on required role
- Token expiration is handled with 401 responses

### Role-Based Access Control
| Endpoint | VOLUNTEER | NGO | CORPORATE | ADMIN |
|----------|-----------|-----|-----------|-------|
| Register/Login | ✅ | ✅ | ✅ | ✅ |
| View Postings | ✅ | ✅ | ✅ | ✅ |
| Create Posting | ❌ | ✅ | ❌ | ✅ |
| Update/Delete Own | ❌ | ✅ | ❌ | ✅ |
| Update/Delete Any | ❌ | ❌ | ❌ | ✅ |
| Analytics | ❌ | ❌ | ❌ | ✅ |

## 🧪 Test Assertions

Each request includes comprehensive test assertions:

```javascript
test("Should register volunteer successfully", function() {
  expect(res.status).to.equal(201);
  expect(res.body.email).to.equal("john.volunteer@example.com");
  expect(res.body.role).to.equal("VOLUNTEER");
});

test("Should create posting successfully", function() {
  expect(res.status).to.equal(201);
  expect(res.body).to.have.property("id");
  expect(res.body.title).to.equal("Community Garden Volunteer Program");
  expect(res.body.domain).to.equal("Environment");
});
```

## 🛠️ Troubleshooting

### Common Issues

1. **401 Unauthorized**: Run login requests first to get JWT tokens
2. **403 Forbidden**: Check role permissions for the endpoint
3. **404 Not Found**: Verify service is running and posting/user IDs exist
4. **Service Unavailable**: Check Docker Compose status

### Debugging Commands
```bash
# Check service logs
docker compose logs user-service
docker compose logs ngo-posting-service
docker compose logs matching-service
docker compose logs analytics-service

# Check API Gateway
curl -v http://localhost:8085/users/actuator/health
curl -v http://localhost:8085/postings/actuator/health

# Direct service access (bypass gateway)
curl -v http://localhost:8080/actuator/health  # User Service
curl -v http://localhost:8082/actuator/health  # NGO Postings
curl -v http://localhost:8081/actuator/health  # Matching Service
curl -v http://localhost:8000/docs             # Analytics Service
```

### API Gateway Verification
```bash
# Test routing through gateway
curl http://localhost:8085/users/api/v1/users/volunteers
curl http://localhost:8085/postings/api/v1/postings
curl http://localhost:8085/match/api/v1/matching/recommend/1
curl http://localhost:8085/analytics/api/v1/admin/analytics/user-insights
```

## 📋 Testing Checklist

- [ ] All services are running via Docker Compose
- [ ] API Gateway is routing correctly (port 8085)
- [ ] Authentication flows work for all user types
- [ ] JWT tokens are automatically saved and used
- [ ] NGO can create and manage postings
- [ ] Volunteers can register for postings
- [ ] Matching service provides recommendations
- [ ] Analytics endpoints return data
- [ ] Cross-service integration works
- [ ] Error handling works properly
- [ ] Cleanup operations complete successfully

## 🔗 Related Documentation

- **API Gateway Configuration**: `/api-gateway/nginx.conf`
- **Docker Compose Setup**: `/docker-compose.yml`
- **Service Documentation**:
  - User Service: `/User-Service/openapi.yaml`
  - NGO Postings: `/NGO-Postings-Service/README.md`
  - Analytics Service: `/Analytics-Service/swagger.yaml`
- **Swagger UIs** (through API Gateway):
  - http://localhost:8085/users/swagger-ui/index.html
  - http://localhost:8085/postings/swagger-ui/index.html
  - http://localhost:8085/match/swagger-ui/index.html
  - http://localhost:8085/analytics/docs

## 🚀 Production Considerations

When testing against production:
1. Update `base_url` to production API Gateway URL
2. Use production credentials
3. Test with realistic data volumes
4. Validate HTTPS/SSL certificates
5. Check rate limiting and authentication
6. Monitor performance and response times

---

🎯 **Ready to test!** Import the collection into Bruno and start with the authentication flows. All requests are pre-configured with proper headers, authentication, and test assertions for comprehensive API validation.