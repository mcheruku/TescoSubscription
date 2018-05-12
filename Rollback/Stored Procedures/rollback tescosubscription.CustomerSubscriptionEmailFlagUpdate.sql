/*

	Author:			Saritha Kommineni
	Date created:	13-Sep-2011
	Purpose:		Rollback Procedure [tescosubscription].[CustomerSubscriptionEmailFlagUpdate]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionEmailFlagUpdate]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionEmailFlagUpdate]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionEmailFlagUpdate]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionEmailFlagUpdate] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionEmailFlagUpdate] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [tescosubscription].[CustomerSubscriptionEmailFlagUpdate] does not exist.'
	END
GO
