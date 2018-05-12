/*

	Author:			Manjunathan Raman
	Date created:	01-Oct-2012
	Purpose:		Schema For Coupons

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.SCHEMATA WHERE [schema_name] = 'Coupon')
	BEGIN

		EXEC sp_executesql N'CREATE SCHEMA [Coupon] AUTHORIZATION [dbo]'

		IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.SCHEMATA WHERE [schema_name] = 'Coupon')
			BEGIN
				PRINT 'SUCCESS - Schema [Coupon] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Schema [Coupon] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Schema [Coupon] already exists.'
	END
GO
