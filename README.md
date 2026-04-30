

\## Stack
dbt
DuckDB
Reflex

\## Data Model
CFO: revenue, avg ticket, orders
COO: delivery time
Customer experience: review scores
Marketplace: top sellers and categories

\## Key Decisions
Revenue based only on delivered orders
Aggregations in dbt

\## How to Run

```bash
dbt seed
dbt run
reflex run

