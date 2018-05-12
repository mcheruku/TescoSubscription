/*

	Author:			Robin
	Date created:	24-Jan-2013
	Purpose:		Rollback Procedure tescosubscription.CustomerSubscriptionEmailFlagUpdate1 

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'tescosubscription.CustomerSubscriptionEmailFlagUpdate1 ',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE tescosubscription.CustomerSubscriptionEmailFlagUpdate1 

		IF OBJECT_ID(N'tescosubscription.CustomerSubscriptionEmailFlagUpdate1 ',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure tescosubscription.CustomerSubscriptionEmailFlagUpdate1  dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure tescosubscription.CustomerSubscriptionEmailFlagUpdate1  not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure tescosubscription.CustomerSubscriptionEmailFlagUpdate1  does not exist.'
	END
GO
