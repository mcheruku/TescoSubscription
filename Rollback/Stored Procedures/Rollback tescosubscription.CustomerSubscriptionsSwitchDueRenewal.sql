/*

	Author:			Robin
	Date created:	17-Jan-2013
	Purpose:		Rollback Procedure [tescosubscription].[tescosubscription.CustomerSubscriptionsSwitchDueRenewal.sql]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[tescosubscription.CustomerSubscriptionsSwitchDueRenewal.sql]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[tescosubscription.CustomerSubscriptionsSwitchDueRenewal.sql]

		IF OBJECT_ID(N'[tescosubscription].[tescosubscription.CustomerSubscriptionsSwitchDueRenewal.sql]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[tescosubscription.CustomerSubscriptionsSwitchDueRenewal.sql] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[tescosubscription.CustomerSubscriptionsSwitchDueRenewal.sql] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [tescosubscription].[tescosubscription.CustomerSubscriptionsSwitchDueRenewal.sql] does not exist.'
	END
GO
