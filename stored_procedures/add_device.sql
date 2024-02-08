CREATE DEFINER=`root`@`localhost` PROCEDURE `add_device`(IN p_FBUID VARCHAR(255), IN p_device VARCHAR(255), IN p_ip_address VARCHAR(255))
BEGIN
	DECLARE v_account_id INT;
    DECLARE v_device_id INT;
    CALL processSMUID(p_FBUID, @v_account_id);
    SET v_account_id = @v_account_id;
    
    if p_device IS NOT NULL THEN
		SELECT device_id INTO v_device_id
		FROM device_make
		WHERE make_name = p_device;
			IF v_device_id IS NULL THEN
				INSERT INTO device_make(make_name)
				VALUES (p_device);
				INSERT INTO device_model(model_name, make_id)
				VALUES("UNKNOWN", LAST_INSERT_ID());
				INSERT INTO device(id_address, model_id, account_id)
				VALUES(p_ip_address, LAST_INSERT_ID(), v_account_id);
			END IF;
	END IF;
END