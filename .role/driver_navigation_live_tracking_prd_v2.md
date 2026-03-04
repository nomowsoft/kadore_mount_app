# Product Requirements Document (PRD)
## Component: Interactive Map - The Heart of Customer Experience

---

## 1. Overview

### Goal
Develop the interactive map component within the customer application to be the **core element** driving the purchase experience, connecting:
- The customer's real location
- Mobile truck locations (points of sale)
- Estimated Time of Arrival (ETA)
- The purchase decision process

### Core Value
The map is not just a tracking tool, but the **primary purchase motivator** by showing:
- **Immediate Availability**: "There's a truck near you right now"
- **Speed**: "Arrival in just 3 minutes"
- **Transparency**: "Know exactly where your order is"

---

## 2. Problem Statement

### Current Challenges
- Customer doesn't know if delivery is available in their area
- Delivery times are inaccurate and unreliable
- Customer hesitates to order because they don't know when it will arrive
- Disconnected experience between product selection and delivery time knowledge

### Proposed Solution
An intelligent interactive map that puts the **customer at the center** and shows them:
- All nearby trucks
- Real-time arrival time for each truck
- Ability to order from the closest truck

---

## 3. Scope

### ✅ In Scope (Phase 1)
- Display interactive map (Google Maps / Mapbox)
- Automatically detect customer location
- Display truck locations (animated icons)
- Calculate and display ETA for nearest truck
- Real-time truck location updates
- Show truck status (available/busy)
- "Order Now" button from nearest truck

### ❌ Out of Scope (Phase 1)
- Multi-stop route optimization for trucks
- Advanced traffic analytics
- Route customization based on future orders
- Augmented Reality (AR) for finding trucks

---

## 4. Target Users

### Customer (Primary)
- Wants to know: Is there a truck nearby?
- Wants to know: When will the truck arrive?
- Wants to order with confidence and speed

### Admin (Secondary)
- Monitor truck distribution
- Analyze area coverage

---

## 5. User Stories

### As a Customer
- "As a customer, I want to see nearby trucks on the map to know if delivery is available in my area."
- "As a customer, I want to know the remaining time for the nearest truck to arrive so I can decide whether to order now or later."
- "As a customer, I want to see the truck moving on the map after ordering to track my order."
- "As a customer, I want to know if the truck is available to receive new orders or if it's busy."

### As an Admin
- "As an admin, I want to see truck distribution across areas to improve coverage."
- "As an admin, I want to analyze high-demand areas to direct more trucks to them."

---

## 6. Functional Requirements

### 6.1 Map Display
- **Map Type**: Google Maps or Mapbox (depending on cost and features)
- **Controls**: Zoom, pan, current location button
- **Icons**:
  - 🧑 Customer icon (static or moving)
  - 🚚 Truck icon (with color-coded status)
    - 🟢 Available truck
    - 🟡 Busy truck - on delivery route
    - 🔴 Offline truck

### 6.2 Location Detection
- Request location permission on first app launch
- Use GPS for accurate location (±10 meters)
- Update customer location every 30 seconds (or when map is moved)
- Support manual location entry (if permission denied)

### 6.3 Truck Visualization
- Fetch active trucks list from Firebase (`live_trucks`)
- Update truck locations every 5-10 seconds (Real-time)
- Show number of available trucks in the area
- Show truck movement path (optional)

### 6.4 ETA Calculation
- **Distance Calculation**: Between customer location and truck location
- **Time Calculation**: Based on:
  - Actual road distance (Routing)
  - Average truck speed
  - Traffic conditions (if available)
- **ETA Update**: Every 10-15 seconds
- **ETA Accuracy**: ±2 minutes

### 6.5 Map Interaction
- **Tap on Truck**: Show quick information:
  - Driver name (optional)
  - Status (available/busy)
  - ETA to customer location
  - "Order from this truck" button
- **Tap on Customer Location**: Re-center map
- **"Nearest Truck" Button**: Zoom to closest truck

### 6.6 Order Integration
- When clicking "Order":
  - Navigate customer to products page
  - Automatically link order to this truck
  - Show customized ETA for this order

### 6.7 Post-Order
- Change selected truck icon to different color
- Display truck route to customer location
- Update ETA in real-time
- Notifications when truck arrives (500m distance)

---

## 7. Non-Functional Requirements

### Performance
- **Map Load Time**: Less than 2 seconds
- **Truck Location Updates**: Every 5-10 seconds
- **ETA Updates**: Every 10 seconds
- **Data Usage**: Less than 5 MB/hour

### Security
- Encrypt all location data (HTTPS)
- Strict Firebase security rules
- No storage of customer location history

### Battery Optimization
- Reduce location updates when map is not moving
- Stop updates when app is backgrounded
- Use Geofencing for smart updates

### Compatibility
- Android 8.0+
- iOS 13+
- Various screen resolutions

---
