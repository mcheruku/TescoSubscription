USE TescoSubscription
GO
/*

	Author:			Infosys Pvt. Ltd.
	Date created:	23-Jul-2013
	Purpose:		This constraint maintains relationship between tables [Coupon].[Coupon] and [Coupon].[Campaign]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[Coupon]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[Coupon].[Campaign]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_Coupon_Campaign_CampaignID')
			BEGIN

				ALTER TABLE [Coupon].[Coupon] WITH NOCHECK ADD  CONSTRAINT [FK_Coupon_Campaign_CampaignID] FOREIGN KEY([CampaignId])
				REFERENCES [Coupon].[Campaign] ([CampaignID])

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_Coupon_Campaign_CampaignID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_Coupon_Campaign_CampaignID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_Coupon_Campaign_CampaignID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_Coupon_Campaign_CampaignID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [Coupon].[Coupon]/[Coupon].[Campaign] does not exist.',16,1)
	END
GO
