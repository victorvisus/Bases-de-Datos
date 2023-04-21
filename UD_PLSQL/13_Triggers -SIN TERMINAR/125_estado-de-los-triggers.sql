-- Comprobar estado de un trigger
/* Para ver los triggers se usa la tabla user_triggers */
desc user_triggers;

select trigger_name, trigger_type, triggering_event, action_type, trigger_body
from user_triggers;

select OBJECT_NAME, object_type, status 
  FROM USER_OBJECTS
  WHERE object_type = 'TRIGGER';