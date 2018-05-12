/*

	Author:			Manjunathan
	Date created:	01-Oct-2012
	Purpose:		Rollback Schema [Coupon]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.SCHEMATA WHERE [schema_name] = 'Coupon')
	BEGIN

		DROP SCHEMA [Coupon]

		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.SCHEMATA WHERE [schema_name] = 'Coupon')
			BEGIN
				PRINT 'SUCCESS - Schema [Coupon] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Schema [Coupon] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Schema [Coupon] does not exist.'
	END
GO
