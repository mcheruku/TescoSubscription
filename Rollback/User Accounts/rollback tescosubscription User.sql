/*

	Created By:		saritha Kommineni
	Date created:	28 Jul 2011
	Purpose:		ROLLBACK script for SubsUser schema user.
      
    --Modifications History--
	Changed On	Changed By	Defect			Description

*/

--Drop database user
IF EXISTS(SELECT 1 FROM sys.sysusers WHERE [name] = 'SubsUser')
	BEGIN
	
		DROP USER [SubsUser]
			
		IF NOT EXISTS(SELECT 1 FROM sys.sysusers WHERE [name] = 'SubsUser')
			BEGIN
				PRINT 'SUCCESS - User [SubsUser] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - User [SubsUser] not dropped.',16,1)
			END
			
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - User [SubsUser] does not exist.'
	END

--Drop server login
IF EXISTS(SELECT 1 FROM sys.sql_logins WHERE [name] = 'SubsUser')
	BEGIN
	
		DROP LOGIN [SubsUser]
			
		IF NOT EXISTS(SELECT 1 FROM sys.sql_logins WHERE [name] = 'SubsUser')
			BEGIN
				PRINT 'SUCCESS - Login [SubsUser] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Login [SubsUser] not dropped.',16,1)
			END
			
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Login [SubsUser] does not exist.'
	END

GO