import os
import dlt
import pandas as pd

from kaggle.api.kaggle_api_extended import KaggleApi

DATA_DIR = "/tmp/olist_data"


def download_olist():
    if not os.path.exists(DATA_DIR):
        os.makedirs(DATA_DIR, exist_ok=True)

    # check if already downloaded
    if not os.path.exists(os.path.join(DATA_DIR, "brazilian-ecommerce.zip")):
        api = KaggleApi()
        api.authenticate()

        api.dataset_download_files(
            "olistbr/brazilian-ecommerce", path=DATA_DIR, unzip=True
        )


@dlt.resource
def load_customers():
    df = pd.read_csv(os.path.join(DATA_DIR, "olist_customers_dataset.csv"))
    yield df


@dlt.resource
def load_geolocation():
    df = pd.read_csv(os.path.join(DATA_DIR, "olist_geolocation_dataset.csv"))
    yield df


@dlt.resource
def load_order_items():
    df = pd.read_csv(os.path.join(DATA_DIR, "olist_order_items_dataset.csv"))
    yield df


@dlt.resource
def load_order_payments():
    df = pd.read_csv(os.path.join(DATA_DIR, "olist_order_payments_dataset.csv"))
    yield df


@dlt.resource
def load_order_reviews():
    df = pd.read_csv(os.path.join(DATA_DIR, "olist_order_reviews_dataset.csv"))
    yield df


@dlt.resource
def load_orders():
    df = pd.read_csv(os.path.join(DATA_DIR, "olist_orders_dataset.csv"))
    yield df


@dlt.resource
def load_products():
    df = pd.read_csv(os.path.join(DATA_DIR, "olist_products_dataset.csv"))
    yield df


@dlt.resource
def load_sellers():
    df = pd.read_csv(os.path.join(DATA_DIR, "olist_sellers_dataset.csv"))
    yield df


@dlt.resource
def load_product_category_name_translation():
    df = pd.read_csv(os.path.join(DATA_DIR, "product_category_name_translation.csv"))
    yield df


def run():
    download_olist()

    pipeline = dlt.pipeline(
        pipeline_name="olist_pipeline", destination="bigquery", dataset_name="olist_raw"
    )

    load_info = pipeline.run(
        [
            load_customers(),
            load_geolocation(),
            load_order_items(),
            load_order_payments(),
            load_order_reviews(),
            load_orders(),
            load_products(),
            load_sellers(),
            load_product_category_name_translation(),
        ]
    )

    print(load_info)


if __name__ == "__main__":
    run()
