USE TescoSubscription
GO
/*

	Author:			Robin
	Date created:	20-April-2014
	Purpose:		Rollback Foreign Key [tescosubscription].[FK_CustomerPaymentRemainingDetail_CustomerSubscription_CustomerSubscriptionID]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[tescosubscription].[FK_CustomerPaymentRemainingDetail_CustomerSubscription_CustomerSubscriptionID]') 
	 AND parent_object_id = OBJECT_ID(N'[tescosubscription].[CustomerPaymentRemainingDetail]'))
	BEGIN

		ALTER TABLE [tescosubscription].[CustomerPaymentRemainingDetail] DROP CONSTRAINT [FK_CustomerPaymentRemainingDetail_CustomerSubscription_CustomerSubscriptionID]

		IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[tescosubscription].[FK_CustomerPaymentRemainingDetail_CustomerSubscription_CustomerSubscriptionID]') 
		 AND parent_object_id = OBJECT_ID(N'[tescosubscription].[CustomerPaymentRemainingDetail]'))
			BEGIN
				PRINT 'SUCCESS - Foreign Key [tescosubscription].[FK_CustomerPaymentRemainingDetail_CustomerSubscription_CustomerSubscriptionID] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Foreign Key [tescosubscription].[FK_CustomerPaymentRemainingDetail_CustomerSubscription_CustomerSubscriptionID] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Foreign Key [tescosubscription].[FK_CustomerPaymentRemainingDetail_CustomerSubscription_CustomerSubscriptionID] does not exist.'
	END
GO
