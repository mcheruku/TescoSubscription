	IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentUpdate]',N'P') IS NOT NULL
		BEGIN

			DROP PROCEDURE [tescosubscription].[CustomerPaymentUpdate]

			IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentUpdate]',N'P') IS NULL
				BEGIN
					PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerPaymentUpdate] dropped.'
				END
			ELSE
				BEGIN
					RAISERROR('FAIL - Procedure [tescosubscription].[CustomerPaymentUpdate] not dropped.',16,1)
				END
		END
	GO






	CREATE PROCEDURE [tescosubscription].[CustomerPaymentUpdate] 
	(
		 @CustomerPaymentID				BIGINT
		,@PaymentAmount					SMALLMONEY
	)
	AS
	/*  Author:			Manjunathan Raman
		Date created:	25 Aug 2011
		Purpose:		Updates Customer Payment
		Behaviour:		Updates Customer Payment after successful Authorisation and makes other Payment Detail specific to the Customer as Inactive
		Usage:			Whenever a customer Places a new Payment Detail
		Called by:		Appstore method CreateCustomerPayment
		WarmUP Script:	Execute [tescosubscription].[CustomerPaymentUpdate] 121334, 1
	--Modifications History--
		Changed On		Changed By		Defect Ref		Change Description
		<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
	
	*/


	BEGIN

		DECLARE		@CustomerID					BIGINT
					,@PaymentModeID				TINYINT 
					,@CurrentUTCDate		DATETIME
					,@errorDescription	NVARCHAR(2048)
					,@error				INT
					,@errorProcedure	SYSNAME
					,@errorLine			INT
					,@PreAuthAmount	SMALLMONEY
					
		SET NOCOUNT ON;	

		SELECT	@CurrentUTCDate = GETUTCDATE(),@PreAuthAmount = 2
				,@CustomerID=CustomerID,@PaymentModeID=PaymentModeID
		 FROM
			[tescosubscription].[CustomerPayment]
		WHERE CustomerPaymentID=@CustomerPaymentID
		
			
		BEGIN TRY
		BEGIN TRANSACTION PaymentUpdate

	-- make others inactive
			UPDATE	[tescosubscription].[CustomerPayment]
			SET		[IsActive]			=	0,
					UTCUpdatedDateTime  =   @CurrentUTCDate
  			WHERE	CustomerID			=	@CustomerID
			AND		PaymentModeID		=	@PaymentModeID	
		
			UPDATE	[tescosubscription].[CustomerPayment]
							SET		[IsActive]	=	1
							,@CustomerPaymentID=CustomerPaymentID
							,IsFirstPaymentDue = CASE WHEN @PaymentAmount > @PreAuthAmount THEN 0 ELSE IsFirstPaymentDue END
							,UTCUpdatedDateTime  =   @CurrentUTCDate
			FROM	[tescosubscription].[CustomerPayment]
							WHERE	CustomerPaymentID=@CustomerPaymentID
				
		COMMIT TRANSACTION PaymentUpdate
		END TRY
		BEGIN CATCH

		  SELECT      @errorProcedure         = Routine_Schema  + '.' + Routine_Name
					  , @error                = ERROR_NUMBER()
					  , @errorDescription     = ERROR_MESSAGE()
					  , @errorLine            = ERROR_LINE()
		  FROM  INFORMATION_SCHEMA.ROUTINES
		  WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)

		 ROLLBACK TRANSACTION PaymentUpdate
		 RAISERROR('[Procedure:%s Line:%i Error:%i] %s',16,1,@errorProcedure,@errorLine,@error,@errorDescription)
	 
		END CATCH

				
	END
	GO
	--Grant execute permissions as required by any calling application.
	GRANT EXECUTE ON [tescosubscription].[CustomerPaymentUpdate] TO [SubsUser]

	GO


	IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentUpdate]',N'P') IS NOT NULL
		BEGIN
			PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerPaymentUpdate] created.'
		END
	ELSE
		BEGIN
			RAISERROR('FAIL - Procedure [tescosubscription].[CustomerPaymentUpdate] not created.',16,1)
		END
	GO
