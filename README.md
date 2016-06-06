# assetid  [![Build Status](https://travis-ci.org/axiom-data-science/assetid.svg)](https://travis-ci.org/axiom-data-science/assetid)

An ocean data asset ID parser developed and used by [Axiom Data Science](http://axiomdatascience.com)


## Installation

##### Stable

    pip install assetid

##### Development

    pip install git+https://github.com/axiom-data-science/assetid.git


### IOOS URNs
[More Information](https://geo-ide.noaa.gov/wiki/index.php?title=IOOS_Conventions_for_Observing_Asset_Identifiers)

###### URN Normalization

```python
from assetid.urn import IoosUrn
u = IoosUrn(asset_type='station', authority='axiom', label='station1')
print u.__dict__
{'asset_type': 'station',
 'authority': 'axiom',
 'component': None,
 'label': 'station1',
 'version': None}
print u.urn
'urn:ioos:station:axiom:station1'
```

```python
from assetid.urn import IoosUrn
u = IoosUrn.from_string('urn:ioos:station:axiom:station1')
print u.__dict__
{'asset_type': 'station',
 'authority': 'axiom',
 'component': None,
 'label': 'station1',
 'version': None}
print u.urn
'urn:ioos:station:axiom:station1'
```

###### NetCDF Integration

```python
from assetid.utils import urnify, dictify_urn

# NetCDF variable attributes from a "sensor" urn
print dictify_urn('urn:ioos:sensor:axiom:station1')
{'standard_name': 'wind_speed'}

print dictify_urn('urn:ioos:sensor:axiom:foo:lwe_thickness_of_precipitation_amount#cell_methods=time:mean,time:variance;interval=pt1h')
{'standard_name': 'lwe_thickness_of_precipitation_amount',
 'cell_methods': 'time: mean time: variance (interval: PT1H)'}

# URN from `dict` of variable attributes
attributes = {'standard_name': 'wind_speed',
              'cell_methods': 'time: mean (interval: PT24H)'}
print urnify('authority', 'label', attributes)
'urn:ioos:sensor:authority:label:wind_speed#cell_methods=time:mean;interval=pt24h'

# URN from a `netCDF4` Variable object
nc = netCDF4.Dataset('http://thredds45.pvd.axiomalaska.com/thredds/dodsC/grabbag/USGS_CMG_WH_OBS/WFAL/9001rcm-a.nc')
print urnify('authority', 'label', nc.variables['T_28'])
'urn:ioos:sensor:authority:label:sea_water_temperature'
```
