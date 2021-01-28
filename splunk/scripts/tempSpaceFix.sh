#!/bin/bash

rm -rf /export/npindx/db_np/db && rm -rf /export/npindx/db_np/colddb && rm -rf /export/npindx/db_np/thaweddb
mkdir /export/npindx/db_np/db && mkdir /export/npindx/db_np/colddb && mkdir /export/npindx/db_np/thaweddb

rm -rf /export/npindx/os_evt_np/db && rm -rf /export/npindx/os_evt_np/colddb && rm -rf /export/npindx/os_evt_np/thaweddb
mkdir /export/npindx/os_evt_np/db && mkdir /export/npindx/os_evt_np/colddb && mkdir /export/npindx/os_evt_np/thaweddb

rm -rf /export/npindx/wls_np/db && rm -rf /export/npindx/wls_np/colddb && rm -rf /export/npindx/wls_np/thaweddb
mkdir /export/npindx/wls_np/db && mkdir /export/npindx/wls_np/colddb && mkdir /export/npindx/wls_np/thaweddb

chown --recursive /export/npindx
# recreate in web ui