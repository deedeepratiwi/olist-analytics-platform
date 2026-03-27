import dlt
import pandas as pd
import os

@dlt.resource
def load_customers():
    df = pd.read_csv("../data/olist_customers_dataset.csv")
    yield df

@dlt.resource
def load_geolocation():
    df = pd.read_csv("../data/olist_geolocation_dataset.csv")
    yield df

@dlt.resource
def load_order_items():
    df = pd.read_csv("../data/olist_order_items_dataset.csv")
    yield df

@dlt.resource
def load_order_payments():
    df = pd.read_csv("../data/olist_order_payments_dataset.csv")
    yield df

@dlt.resource
def load_order_reviews():
    df = pd.read_csv("../data/olist_order_reviews_dataset.csv")
    yield df

@dlt.resource
def load_orders():
    df = pd.read_csv("../data/olist_orders_dataset.csv")
    yield df

@dlt.resource
def load_products():
    df = pd.read_csv("../data/olist_products_dataset.csv")
    yield df

@dlt.resource
def load_sellers():
    df = pd.read_csv("../data/olist_sellers_dataset.csv")
    yield df

@dlt.resource
def load_product_category_name_translation():
    df = pd.read_csv("../data/product_category_name_translation.csv")
    yield df


def run():
    pipeline = dlt.pipeline(
        pipeline_name="olist_pipeline",
        destination="bigquery",
        dataset_name="olist_raw"
    )

    load_info = pipeline.run([
        load_customers(),
        load_geolocation(),
        load_order_items(),
        load_order_payments(),
        load_order_reviews(),
        load_orders(),
        load_products(),
        load_sellers(),
        load_product_category_name_translation()
    ])

    print(load_info)


if __name__ == "__main__":
    run()