USE TescoSubscription
GO
/*

	Author:			Infosys Pvt. Ltd.
	Date created:	23-Jul-2013
	Purpose:		Rollback Foreign Key [Coupon].[FK_Coupon_Campaign_CampaignID]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[Coupon].[FK_Coupon_Campaign_CampaignID]') 
	 AND parent_object_id = OBJECT_ID(N'[Coupon].[Coupon]'))
	BEGIN

		ALTER TABLE [Coupon].[Coupon] DROP CONSTRAINT [FK_Coupon_Campaign_CampaignID]

		IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[Coupon].[FK_Coupon_Campaign_CampaignID]') 
		 AND parent_object_id = OBJECT_ID(N'[Coupon].[Coupon]'))
			BEGIN
				PRINT 'SUCCESS - Foreign Key [Coupon].[FK_Coupon_Campaign_CampaignID] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Foreign Key [Coupon].[FK_Coupon_Campaign_CampaignID] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Foreign Key [Coupon].[FK_Coupon_Campaign_CampaignID] does not exist.'
	END
GO
