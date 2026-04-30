# Olist Dashboard

## Overview
This project is an end-to-end analytics solution built on top of the Olist e-commerce dataset.
The idea was to create a simple but useful dashboard for executives, showing how the business is doing from different angles like revenue, operations, customer experience and marketplace performance.
I used dbt to model the data, DuckDB as a local warehouse, and Reflex to build the dashboard.

## Goal
The goal of this dashboard is to give a quick and clear view of the business health.
Instead of digging through raw data, the executive team can open the dashboard and immediately understand:

- how much revenue is being generated
- how well operations are performing
- how satisfied customers are
- which sellers and product categories are driving results

## Key Metrics
I grouped the metrics by stakeholder to make it easier to consume.

### CFO
- Total Orders - gives a sense of scale
- Revenue (only delivered orders) - avoids inflating numbers with cancellations
- Average Ticket - helps understand customer spending
- Product vs Freight Revenue - shows how revenue is composed

### COO
- Average Delivery Time - quick way to track logistics performance

### Customer Experience
- Average Review Score - overall satisfaction
- Total Reviews - volume of feedback

### Marketplace
- Top Sellers - highlights key partners
- Top Categories by Revenue - more useful than product IDs for decision making

### Time Analysis
- Revenue by Month - shows how the business evolves over time

## How this helps decision making
The dashboard is meant to support practical decisions, not just display numbers.

Examples:
- If a category is consistently generating more revenue, it might be worth investing more there
- If delivery time is too high, operations might need attention
- If review scores drop, that’s a clear signal to investigate customer experience issues
- Top sellers can be prioritized for partnerships or incentives

## Data Sources

The project uses the public Olist dataset, which includes:

- Orders
- Order items
- Payments
- Reviews
- Products
- Sellers
- Customers
- Geolocation

The data is loaded into DuckDB using dbt seeds, and then transformed into business-ready tables (marts).


## How to run locally

1. Install dependencies

```bash
pip install -r requirements.txt
dbt seed
dbt run
reflex run

Open http://localhost:3000 in browser
