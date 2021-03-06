
IF OBJECT_ID(N'[tescosubscription].[PaymentInstallmentGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[PaymentInstallmentGet]

		IF OBJECT_ID(N'[tescosubscription].[PaymentInstallmentGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[PaymentInstallmentGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[PaymentInstallmentGet] not dropped.',16,1)
			END
	END
GO



	
	CREATE PROCEDURE [tescosubscription].[PaymentInstallmentGet]
		-- Add the parameters for the stored procedure here
		
	AS
	/*

	Author:			Robin
	Date created:	29/11/2012
	Purpose:		To get list of all PaymentInstallment details  
	Behaviour:		How does this procedure actually work
	Usage:			Hourly/Often
	Called by:		<BOA>
	WarmUP Script:	

	--Modifications History--
 	Changed On   Changed By  Defect  Changes  Change Description 
	12/12/2012	 Robin						  Added  WITH (NOLOCK)
	

*/
	BEGIN
	

		 SET NOCOUNT ON

		  SELECT [PaymentInstallmentID]
			  ,[PaymentInstallmentName]
			 FROM [tescosubscription].[PaymentInstallment] WITH (NOLOCK)
	END





GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[PaymentInstallmentGet] TO [SubsUser]
GO


IF OBJECT_ID(N'[tescosubscription].[PaymentInstallmentGet]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[PaymentInstallmentGet] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[PaymentInstallmentGet] not created.',16,1)
	END
GO
