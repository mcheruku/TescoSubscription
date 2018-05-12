/*

	Author:			Rajendra Singh
	Date created:	<16 Jun 2011>
	Purpose:		To Access tescosubscription DataBase

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
USE tescosubscription
GO
--Create server login
IF NOT EXISTS(SELECT 1 FROM sys.sql_logins WHERE [name] = 'SubsUser')
	BEGIN
	
		--Create a non-expiring server login.
		CREATE LOGIN [SubsUser] WITH
			PASSWORD			=	N'#1234567#',                                 
			CHECK_EXPIRATION	=	OFF,                                                                                                                     
			CHECK_POLICY		=	OFF
			
		IF EXISTS(SELECT 1 FROM sys.sql_logins WHERE [name] = 'SubsUser')
			BEGIN
				PRINT 'SUCCESS - Login [SubsUser] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Login [SubsUser] not created.',16,1)
			END
			
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Login [SubsUser] already exists.'
	END

--Create database user
IF NOT EXISTS(SELECT 1 FROM sys.sysusers WHERE [name] = 'SubsUser')
	BEGIN
	
		--Create a DB user for the Server login created above.
		CREATE USER [SubsUser] FOR LOGIN [SubsUser]
			
		IF EXISTS(SELECT 1 FROM sys.sysusers WHERE [name] = 'SubsUser')
			BEGIN
				PRINT 'SUCCESS - User [SubsUser] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - User [SubsUser] not created.',16,1)
			END
			
	END
ELSE
	BEGIN
		PRINT 'EXISTS - User [SubsUser] already exists.'
	END

GO