USE TescoSubscription
GO
/*

	Author:			Infosys Pvt Ltd
	Date created:	23-Jul-2013
	Purpose:		This constraint maintains relationship between tables [Coupon].[Campaign] and [Coupon].[CampaignTypeMaster]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[Campaign]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[Coupon].[CampaignTypeMaster]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_Campaign_CampaignTypeMaster_CampaignTypeID')
			BEGIN

			ALTER TABLE [Coupon].[Campaign]  WITH NOCHECK ADD  CONSTRAINT [FK_Campaign_CampaignTypeMaster_CampaignTypeID] FOREIGN KEY([CampaignTypeID])
			REFERENCES [Coupon].[CampaignTypeMaster] ([CampaignTypeID])
			NOT FOR REPLICATION 
		

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_Campaign_CampaignTypeMaster_CampaignTypeID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_Campaign_CampaignTypeMaster_CampaignTypeID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_Campaign_CampaignTypeMaster_CampaignTypeID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_Campaign_CampaignTypeMaster_CampaignTypeID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [Coupon].[Campaign]/[Coupon].[CampaignTypeMaster] does not exist.',16,1)
	END
GO
