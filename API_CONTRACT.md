# API Contract - Event Hall Booking Platform

## 1. User Authentication

### Login
- **The Feature**: User login (both Hall Owners and Customers)
- **HTTP Method**: POST
- **Endpoint Path**: `/api/auth/login`
- **Description**: Authenticates a user and returns a JWT token.
- **Request Body (if applicable)**:
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```
- **Success Response (200 OK)**:
```json
{
  "token": "jwt_token_string",
  "user": {
    "id": "12345",
    "role": "customer",
    "name": "John Doe"
  }
}
```
- **Error Response(s)**:
```json
{
  "error": "Invalid email or password"
}
```

### Register
- **The Feature**: User registration
- **HTTP Method**: POST
- **Endpoint Path**: `/api/auth/register`
- **Description**: Registers a new Hall Owner or Customer account.
- **Request Body (if applicable)**:
```json
{
  "name": "John Doe",
  "email": "user@example.com",
  "password": "password123",
  "role": "hall_owner"
}
```
- **Success Response (200 OK)**:
```json
{
  "message": "Registration successful. Awaiting approval if Hall Owner."
}
```
- **Error Response(s)**:
```json
{
  "error": "Email already exists"
}
```

## 2. Hall Management

### Register Hall
- **The Feature**: Hall owner registers their hall
- **HTTP Method**: POST
- **Endpoint Path**: `/api/halls/register`
- **Description**: Allows hall owners to register their hall details. Requires admin approval.
- **Request Body (if applicable)**:
```json
{
  "name": "Grand Palace",
  "location": "City Center",
  "capacity": 500,
  "price_per_day": 10000,
  "images": ["url1", "url2"]
}
```
- **Success Response (200 OK)**:
```json
{
  "message": "Hall registered successfully. Awaiting verification."
}
```
- **Error Response(s)**:
```json
{
  "error": "Incomplete hall details"
}
```

## 3. Event Manager Management

### Register Event Manager
- **The Feature**: Event manager registration
- **HTTP Method**: POST
- **Endpoint Path**: `/api/event-managers/register`
- **Description**: Registers an event manager to the platform.
- **Request Body (if applicable)**:
```json
{
  "name": "Elite Events",
  "location": "City Center",
  "services": ["Decor", "Catering"],
  "contact": "9876543210"
}
```
- **Success Response (200 OK)**:
```json
{
  "message": "Event manager registered successfully. Awaiting verification."
}
```
- **Error Response(s)**:
```json
{
  "error": "Missing required fields"
}
```

## 4. Customer Search

### Search Halls
- **The Feature**: Search available halls
- **HTTP Method**: GET
- **Endpoint Path**: `/api/halls/search`
- **Description**: Retrieves a list of halls based on location or keyword.
- **Request Body (if applicable)**: None (use query parameters)
- **Success Response (200 OK)**:
```json
[
  {
    "id": "1",
    "name": "Grand Palace",
    "location": "City Center",
    "price_per_day": 10000
  }
]
```
- **Error Response(s)**:
```json
{
  "error": "No halls found"
}
```

## 5. Advertisement Management

### Feature Listing
- **The Feature**: Display featured halls/event managers
- **HTTP Method**: GET
- **Endpoint Path**: `/api/ads/featured`
- **Description**: Retrieves a list of paid featured listings for homepage display.
- **Request Body (if applicable)**: None
- **Success Response (200 OK)**:
```json
[
  {
    "id": "1",
    "type": "hall",
    "name": "Luxury Banquet Hall",
    "image": "image_url"
  }
]
```
- **Error Response(s)**:
```json
{
  "error": "No featured listings available"
}
```
