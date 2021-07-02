USE [master]
GO
CREATE LOGIN [soporte] 
WITH PASSWORD='soporte', 
DEFAULT_DATABASE=[master], 
DEFAULT_LANGUAGE=[Español], 
CHECK_EXPIRATION=OFF, 
CHECK_POLICY=ON
GO

ALTER LOGIN [soporte] DISABLE
GO

ALTER SERVER ROLE [sysadmin] ADD MEMBER [soporte]
GO

ALTER SERVER ROLE [dbcreator] ADD MEMBER [soporte]
GO


