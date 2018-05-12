USE TescoSubscription

GO
/*

	Author:			Robin John
	Date created:	14-Jan-2014
	Purpose:		This constraint maintains relationship between tables [Coupon].[Campaign] and [Coupon].[CouponUsageType]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[CouponUsageType]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[Coupon].[Campaign]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_Campaign_UsageTypeID')
			BEGIN
ALTER TABLE [Coupon].[Campaign]  WITH CHECK ADD  CONSTRAINT [FK_Campaign_UsageTypeID] FOREIGN KEY([UsageTypeID])
REFERENCES [Coupon].[CouponUsageType] ([UsageTypeID])

ALTER TABLE [Coupon].[Campaign] CHECK CONSTRAINT [FK_Campaign_UsageTypeID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_Campaign_UsageTypeID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_Campaign_UsageTypeID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_Campaign_UsageTypeID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_Campaign_UsageTypeID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [Coupon].[CouponUsageType]/[Coupon].[Campaign] does not exist.',16,1)
	END
GO

GO