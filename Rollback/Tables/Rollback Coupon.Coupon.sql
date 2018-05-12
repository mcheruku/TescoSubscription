/*

	Author:			Manjunathan
	Date created:	01-Oct-2012
	Purpose:		Rollback Table [Coupon].[Coupon]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	10-June-2013	Abhishek 						Remove Campaign ID Column

*/

IF EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Coupon' AND TABLE_SCHEMA = 'Coupon'  AND  COLUMN_NAME = 'CampaignID')
BEGIN	
	ALTER TABLE [Coupon].[Coupon] DROP COLUMN CampaignID
	IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Coupon' AND TABLE_SCHEMA = 'Coupon' AND  COLUMN_NAME = 'CampaignID')
	BEGIN
		PRINT 'SUCCESS - Column CampaignID dropped.'
	END
	ELSE
	BEGIN
		RAISERROR('FAIL - Column CampaignID not dropped.',16,1)
	END
END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Column CampaignID does not exist in [Coupon].[Coupon].'
	END
GO
