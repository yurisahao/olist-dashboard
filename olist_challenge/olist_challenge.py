import reflex AS rx
import duckdb

DB_PATH = r"C:\Users\yuris\.dbt\olist_challenge\dev.duckdb"


def query(sql):
    con = duckdb.connect(DB_PATH, read_only=True)
    result = con.execute(sql).fetchall()
    con.close()
    return result


def metric_card(title, value):
    return rx.card(
        rx.vstack(
            rx.text(title, size="3", color="gray"),
            rx.heading(value, size="6"),
            spacing="2",
        ),
        width="100%",
    )


def index():
    cfo = query("SELECT * FROM cfo_summary")
    coo = query("SELECT * FROM coo")
    cx = query("SELECT * FROM customer_experience")
    sellers = query("SELECT * FROM marketplace limit 5")
    products = query("SELECT * FROM top_products limit 10")
    revenue_month = query("SELECT * FROM revenue_month")

    total_orders, revenue, avg_ticket, product_rev, freight_rev = cfo[0]

    return rx.container(
        rx.vstack(
            rx.heading("C-Level Overview Dashboard", size="9"),
            rx.text("Executive view of financial, operational, customer experience and marketplace performance."),

            rx.heading("CFO", size="6"),
            rx.grid(
                metric_card("Total Orders", f"{total_orders:,}"),
                metric_card("Revenue", f"${revenue:,.0f}"),
                metric_card("Average Ticket", f"${avg_ticket:,.2f}"),
                metric_card("Product Revenue", f"${product_rev:,.0f}"),
                metric_card("Freight Revenue", f"${freight_rev:,.0f}"),
                columns="5",
                spacing="4",
                width="100%",
            ),

            rx.heading("Operations & Customer Experience", size="6"),
            rx.grid(
                metric_card("Avg Delivery Time", f"{coo[0][0]:.2f} days"),
                metric_card("Avg Review Score", f"{cx[0][0]:.2f} / 5"),
                metric_card("Total Reviews", f"{cx[0][1]:,}" ),
                columns="3",
                spacing="4",
                width="100%",
            ),

            rx.heading("Top Sellers", size="6"),
            rx.table.root(
                rx.table.header(
                    rx.table.row(
                        rx.table.column_header_cell("Seller"),
                        rx.table.column_header_cell("Orders"),
                        rx.table.column_header_cell("Revenue"),
                    )
                ),
                rx.table.body(
                    *[
                        rx.table.row(
                            rx.table.cell(str(row[0])),
                            rx.table.cell(str(row[1])),
                            rx.table.cell(f"${row[2]:,.0f}"),
                        )
                        for row in sellers
                    ]
                ),
                width="100%",
            ),
                rx.heading("Top Categories", size="6"),
                rx.table.root(
                    rx.table.header(
                        rx.table.row(
                            rx.table.column_header_cell("Category"),
                            rx.table.column_header_cell("Items Sold"),
                            rx.table.column_header_cell("Orders"),
                            rx.table.column_header_cell("Revenue"),
                        )
                    ),
                    rx.table.body(
                        *[
                            rx.table.row(
                                rx.table.cell(str(row[0])),
                                rx.table.cell(str(row[1])),
                                rx.table.cell(str(row[2])),
                                rx.table.cell(f"${row[3]:,.0f}"),
                            )
                            for row in products
                        ]
                    ),
                    width="100%",
                ),
            spacing="5",
            width="100%",
        ),
                rx.heading("Revenue Over Time", size="6"),

                rx.vstack(
                    *[
                        rx.hstack(
                            rx.text(str(row[0])),
                            rx.text(f"${row[1]:,.0f}")
                        )
                        for row in revenue_month
                    ]
                ),
        size="4",
        padding="2em",
    )


app = rx.App()
app.add_page(index)