/*

	Author:			Robin
	Date created:	5-June-2014
	Purpose:		Rollback Procedure [tescosubscription].[CustomerSubscriptionNextRenewalUpdate2]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionNextRenewalUpdate2]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionNextRenewalUpdate2]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionNextRenewalUpdate2]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionNextRenewalUpdate2] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionNextRenewalUpdate2] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [tescosubscription].[CustomerSubscriptionNextRenewalUpdate2] does not exist.'
	END
GO
