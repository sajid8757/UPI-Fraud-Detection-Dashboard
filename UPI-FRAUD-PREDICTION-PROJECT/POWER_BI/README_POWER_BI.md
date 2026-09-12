# Power BI Dashboard Documentation

## Project

UPI Fraud Detection Dashboard

## Objective

Design a fintech-style interactive Power BI dashboard that helps fraud analysts quickly identify suspicious transactions, investigate risky users and merchants, and monitor fraud KPIs.

## Dashboard Features (Planned)

* Executive Overview
* Fraud Investigation Center
* Customer & Device Analytics
* Merchant Intelligence
* Geo Risk Intelligence
* Bookmark Navigation
* Dynamic KPIs
* Drill Through
* Tooltips
* What-if Parameter

## Dataset

* Source: `transactions_feature_engineered.csv`
* Rows: **200,000**
* Columns: **35**
* Users: **10,000**
* Merchants: **500**
* States: **10**

## Dashboard Theme

* Dark Fintech Theme
* Blue Accent
* Red Alerts
* Rounded Cards
* Interactive Navigation

---

## Progress

* [ ] Data Import
* [ ] Data Model
* [ ] DAX Measures
* [ ] KPI Cards
* [ ] Charts
* [ ] Bookmarks
* [ ] Drill Through
* [ ] Final Dashboard


Phase 9A – Power BI Foundation
What We Completed

Created a professional Power BI project structure.

Imported the final feature-engineered dataset.

Validated data types inside Power Query.

Renamed the fact table to transactions.

Created all report pages before designing visuals.

Prepared a hidden navigation page for future bookmark-based navigation.

Why This Matters

Most beginners directly start creating charts. We first built a proper project foundation, making the PBIX file easier to maintain, expand, and present professionally on GitHub and during interviews.


## Phase 9B – Enterprise Data Model & DAX Foundation

### What We Completed

- Created a dedicated **Measures** table following enterprise Power BI practices.
- Organized measures into display folders for better model management.
- Built the first 12 executive KPI measures using DAX.
- Used `CALCULATE()` for filtered aggregations.
- Used `DIVIDE()` for safe percentage calculations.
- Formatted measures according to reporting standards.

### DAX Concepts Learned

| Function | Purpose |
|----------|---------|
| `COUNTROWS()` | Count records |
| `DISTINCTCOUNT()` | Unique values |
| `CALCULATE()` | Modify filter context |
| `DIVIDE()` | Safe division |
| `AVERAGE()` | Average metric |

### Why This Matters

Instead of keeping measures scattered inside the fact table, we built a dedicated measure layer similar to enterprise Power BI projects. This improves readability, scalability, and interview presentation quality.

### Validation

- All 12 executive KPI measures returned expected values.
- Fraud Rate required percentage formatting (5.57% instead of 0.06).
- Executive KPI cards were successfully created for dashboard development.

## Phase 9C – Premium Executive Dashboard

### Objective

Transform the Executive Overview page into a fintech-style enterprise dashboard with professional UI and dynamic KPIs.

### What We Completed

- Designed a professional dark-theme dashboard canvas.
- Built a structured header with navigation buttons.
- Added an executive alert banner for priority cases.
- Redesigned all KPI cards with consistent sizing and spacing.
- Introduced dynamic KPI coloring using DAX.
- Added a Last Refresh indicator.
- Created a dedicated filter panel.
- Organized dashboard objects using the Selection Pane.
- Locked static layout components to prevent accidental movement.

### DAX Learned

- `SWITCH(TRUE())` for conditional formatting.
- Dynamic color measures.
- KPI-driven visual formatting.

### Professional Practices

- Consistent grid system
- Enterprise spacing
- Rounded cards
- Layer organization
- Locked background
- Navigation-first dashboard design

### Step 11–14 Enhancements

- Added professional KPI icons.
- Applied DAX-based conditional formatting using Field Value.
- Built a dynamic Last Refresh indicator.
- Organized all visuals inside the Selection Pane using enterprise naming conventions.
- Locked static layout elements to protect the dashboard structure.


## Phase 9D – Fraud Investigation Dashboard (Part 1)

### Completed

- Active navigation system.
- Hover effects.
- Fraud page layout.
- Investigation KPI cards.
- Risk Category donut chart.
- Suspicion Reason analysis.

### Power BI Skills Used

- Button States
- Bookmark Navigation
- Donut Charts
- Dynamic Colors
- Interactive Investigation Layout


## Phase 9D – Fraud Investigation Dashboard (Part 2)

### Features Added

- Top P1 investigation table
- Conditional formatting
- Interactive slicers
- Sync slicers
- Drill-through user profile
- Custom tooltip
- Cross-filter interactions

### Business Value

An analyst can:

- Filter fraud by state or merchant.
- Investigate P1 cases instantly.
- Open complete customer profiles.
- View contextual information using tooltips.
- Analyze fraud without writing SQL.

## Phase 10 – Customer & Device Intelligence

### Features Added

- Shared vs Personal Device Analysis
- Device Usage Distribution
- High Activity User Detection
- Burst Activity Monitoring
- User Activity Score Distribution
- Interactive User Investigation
- Cross-filtering
- Drill-through Integration

### Business Value

The dashboard identifies:

- Shared devices used by multiple users.
- Highly active customers requiring monitoring.
- Burst transaction behavior.
- Behavioral fraud patterns beyond simple transaction counts.

## Phase 11 – Merchant Intelligence

### Features Added

- Merchant Risk KPIs
- Category-wise Risk Analysis
- Top 15 Risky Merchants
- Audit Priority Table
- Merchant Quartile Segmentation
- Merchant Drill-through
- Merchant Tooltip
- Cross-filtering

### Business Value

This page helps fraud analysts:

- Prioritize merchant audits.
- Identify high-risk merchant categories.
- Compare suspicious rates across merchants.
- Investigate individual merchants without writing SQL.

## Phase 9F – Geo Risk Intelligence

### Objective

Identify geographical fraud hotspots across Indian states.

### Dashboard Components

- Highest Risk State KPI
- Highest Average Risk KPI
- Filled Risk Map
- P1 Investigation Map
- State Fraud Rate Chart
- P1 Cases Ranking
- Executive Risk Matrix
- Geo Tooltip
- Dynamic Geo Insight

### Business Outcome

Fraud teams can identify high-risk regions instantly and prioritize investigation resources based on geographical fraud concentration.

## Phase 9G – Hidden Navigation & Bookmark Animation

### Objective

Create an enterprise-style sliding navigation menu using Power BI bookmarks.

### Components

- Hamburger Menu
- Slide Navigation Panel
- Close Button
- Page Navigation Buttons
- Open/Close Bookmarks
- Grouped Selection Pane

### Best Practice

Group all navigation objects into `GRP_NAV_PANEL` so future maintenance becomes easier.