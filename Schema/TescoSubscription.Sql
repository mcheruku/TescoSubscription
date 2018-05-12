/*

	Author:			Saritha Kommineni
	Date created:	27-Jul-2011
	Purpose:		creates    tescosubscription schema for tescosubscription DB

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.SCHEMATA WHERE [schema_name] = 'tescosubscription')
	BEGIN

		EXEC sp_executesql N'CREATE SCHEMA [tescosubscription] AUTHORIZATION [dbo]'

		IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.SCHEMATA WHERE [schema_name] = 'tescosubscription')
			BEGIN
				PRINT 'SUCCESS - Schema [tescosubscription] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Schema [tescosubscription] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Schema [tescosubscription] already exists.'
	END
GO
