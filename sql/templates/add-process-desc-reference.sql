
INSERT INTO EVA_PROCESS_DESC_REFERENCE (ID, PROCESS_DESCRIPTOR_ID, PROCESS_DESCRIPTOR_ENV_ID, CONFIG_ID, IS_SHARED) 
VALUES (@PDR.$PROCESS_DESC_REF_ID, @PD.${PROCESS_DESCRIPTOR_ID}, @ENV.Dflt, NULL, 'N');