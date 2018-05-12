USE TescoSubscription

GO
/*

	Author:			Robin John
	Date created:	20-April-2014
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[CustomerPaymentRemainingDetail] and [TescoSubscription].[CustomerSubscription]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[TescoSubscription].[CustomerSubscription]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[CustomerPaymentRemainingDetail]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerPaymentRemainingDetail_CustomerSubscription_CustomerSubscriptionID')
			BEGIN
ALTER TABLE [tescosubscription].[CustomerPaymentRemainingDetail]  WITH CHECK ADD  CONSTRAINT [FK_CustomerPaymentRemainingDetail_CustomerSubscription_CustomerSubscriptionID] FOREIGN KEY([CustomerSubscriptionID])
REFERENCES [TescoSubscription].[CustomerSubscription] ([CustomerSubscriptionID])

ALTER TABLE [tescosubscription].[CustomerPaymentRemainingDetail] CHECK CONSTRAINT [FK_CustomerPaymentRemainingDetail_CustomerSubscription_CustomerSubscriptionID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerPaymentRemainingDetail_CustomerSubscription_CustomerSubscriptionID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerPaymentRemainingDetail_CustomerSubscription_CustomerSubscriptionID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerPaymentRemainingDetail_CustomerSubscription_CustomerSubscriptionID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerPaymentRemainingDetail_CustomerSubscription_CustomerSubscriptionID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [TescoSubscription].[CustomerSubscription]/[tescosubscription].[CustomerPaymentRemainingDetail] does not exist.',16,1)
	END
GO

GO


 