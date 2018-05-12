USE TescoSubscription
GO
/*

	Author:			Infosys Pvt. Ltd.
	Date created:	23-Jul-2013
	Purpose:		Rollback Foreign Key [Coupon].[FK_Campaign_CampaignTypeMaster_CampaignTypeID]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[Coupon].[FK_Campaign_CampaignTypeMaster_CampaignTypeID]') 
	 AND parent_object_id = OBJECT_ID(N'[Coupon].[Campaign]'))
	BEGIN

		ALTER TABLE [Coupon].[Campaign] DROP CONSTRAINT [FK_Campaign_CampaignTypeMaster_CampaignTypeID]

		IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[Coupon].[FK_Campaign_CampaignTypeMaster_CampaignTypeID]') 
		 AND parent_object_id = OBJECT_ID(N'[Coupon].[Campaign]'))
			BEGIN
				PRINT 'SUCCESS - Foreign Key [Coupon].[FK_Campaign_CampaignTypeMaster_CampaignTypeID] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Foreign Key [Coupon].[FK_Campaign_CampaignTypeMaster_CampaignTypeID] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Foreign Key [Coupon].[FK_Campaign_CampaignTypeMaster_CampaignTypeID] does not exist.'
	END
GO
