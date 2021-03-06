USE TescoSubscription
GO
/*

	Author:			Robin
	Date created:	17-Feb-2014
	Purpose:		Rollback Foreign Key [Coupon].[FK_CampaignDiscountType_Campaign]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[Coupon].[FK_CampaignDiscountType_Campaign]') 
	 AND parent_object_id = OBJECT_ID(N'[Coupon].[CampaignDiscountType]'))
	BEGIN

		ALTER TABLE [Coupon].[CampaignDiscountType] DROP CONSTRAINT [FK_CampaignDiscountType_Campaign]

		IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[Coupon].[FK_CampaignDiscountType_Campaign]') 
		 AND parent_object_id = OBJECT_ID(N'[Coupon].[CampaignDiscountType]'))
			BEGIN
				PRINT 'SUCCESS - Foreign Key [Coupon].[FK_CampaignDiscountType_Campaign] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Foreign Key [Coupon].[FK_CampaignDiscountType_Campaign] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Foreign Key [Coupon].[FK_CampaignDiscountType_Campaign] does not exist.'
	END
GO
