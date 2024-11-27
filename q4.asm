section .data
    sensor_value db 90         ; Simulated water level sensor value
    motor_status db 0         ; Motor status: 0 (off), 1 (on)
    alarm_status db 0         ; Alarm status: 0 (off), 1 (on)
    high_threshold db 80      ; High water level threshold
    moderate_threshold db 50  ; Moderate water level threshold

    motor_on_msg db "Motor ON", 10, 0
    motor_off_msg db "Motor OFF", 10, 0
    alarm_on_msg db "ALARM ON", 10, 0
    alarm_off_msg db "ALARM OFF", 10, 0

section .text
    global _start

_start:
    ; Read the sensor value (simulate reading from input port)
    mov al, [sensor_value]    ; Load the sensor value into AL
    call check_sensor         ; Check sensor value and act accordingly

    ; Exit program
    mov rax, 60               ; sys_exit
    xor rdi, rdi              ; Exit code 0
    syscall

; Subroutine: check_sensor
; Determines actions based on sensor input
check_sensor:
    push rax                  ; Save RAX on the stack (if needed elsewhere)
    
    ; Check if water level is too high
    mov al, [sensor_value]    ; Reload sensor value
    cmp al, [high_threshold]  ; Compare with high threshold
    jg .trigger_alarm         ; If greater, trigger alarm

    ; Check if water level is moderate
    cmp al, [moderate_threshold]
    jg .stop_motor            ; If greater than moderate but less than high, stop motor

    ; Otherwise, turn on the motor
    jmp .turn_on_motor

.trigger_alarm:
    mov byte [alarm_status], 1 ; Set alarm status to ON
    mov byte [motor_status], 0 ; Ensure motor is OFF
    mov rsi, alarm_on_msg
    jmp .display_message

.stop_motor:
    mov byte [motor_status], 0 ; Set motor status to OFF
    mov byte [alarm_status], 0 ; Ensure alarm is OFF
    mov rsi, motor_off_msg
    jmp .display_message

.turn_on_motor:
    mov byte [motor_status], 1 ; Set motor status to ON
    mov byte [alarm_status], 0 ; Ensure alarm is OFF
    mov rsi, motor_on_msg

.display_message:
    mov rax, 1                 ; sys_write
    mov rdi, 1                 ; File descriptor (stdout)
    mov rdx, 10                ; Message length
    syscall

    pop rax                    ; Restore RAX
    ret
