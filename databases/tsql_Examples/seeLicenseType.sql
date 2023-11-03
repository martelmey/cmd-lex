SELECT SERVERPROPERTY('LicenseType') as Licensetype, SERVERPROPERTY('NumLicenses') as LicenseNumber,
SERVERPROPERTY('productversion') as Productverion, 
       SERVERPROPERTY ('productlevel')as ProductLevel, 
       SERVERPROPERTY ('edition') as SQLEdition