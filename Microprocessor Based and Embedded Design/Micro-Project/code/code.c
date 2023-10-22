/*******************************************************
This program was created by the
CodeWizardAVR V3.14 Advanced
Automatic Program Generator
� Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : Micro - Final Project
Version : 
Date    : 28/Jun/2023
Author  : Mahdi Abdolhosseini - Javad Shamsaei
Company : 
Comments: 


Chip type               : ATmega32
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 512
*******************************************************/

#include <mega32.h>
#include <delay.h>
#include <stdio.h>
#include <stdlib.h>
#include <alcd.h> // Alphanumeric LCD functions

// Voltage Reference: Int., cap. on AREF
#define ADC_VREF_TYPE ((1<<REFS1) | (1<<REFS0) | (0<<ADLAR))

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= Read the AD conversion result
unsigned char read_adc(unsigned char adc_input)
{
    ADMUX=adc_input | ADC_VREF_TYPE;
    // Delay needed for the stabilization of the ADC input voltage
    delay_us(10);
    // Start the AD conversion
    ADCSRA|=(1<<ADSC);
    // Wait for the AD conversion to complete
    while ((ADCSRA & (1<<ADIF))==0);
    ADCSRA|=(1<<ADIF);
    return ADCW;
}

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= keyboard handler:
int keyboard(){
    int key=20;
    //---- ROW1 ----
    PORTD.3=0;
    delay_ms(2);
    if(PIND.0==0) key=1;
    if(PIND.1==0) key=2;
    if(PIND.2==0) key=3;
    PORTD.3=1;
    //---- ROW2 ----
    PORTD.4=0;
    delay_ms(2);
    if(PIND.0==0) key=4;
    if(PIND.1==0) key=5;
    if(PIND.2==0) key=6;
    PORTD.4=1;
    //---- ROW3 ----
    PORTD.5=0;
    delay_ms(2);
    if(PIND.0==0) key=7;
    if(PIND.1==0) key=8;
    if(PIND.2==0) key=9;
    PORTD.5=1;
    //---- ROW4 ----
    PORTD.6=0;
    delay_ms(2);
    if(PIND.1==0) key=0;
    PORTD.6=1;

    return key;
} //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

#define LCD_WIDTH 16 // LCD has 16 columns

void main(void){
    // Declare your local variables here
    unsigned char temp;
    unsigned char light;
    unsigned char distance;

    char s[15];
    int key = 20;
    int flag = 10;
    int backupFlag = 10;

    int doAnimate = 0;
    int doLEDanimate = 0;
    int x = 0; // Initial x position
    int y = 0; // Initial y position
    int direction = 1; // Initial direction (1: right, -1: left)

    // Input/Output Ports initialization
    // Port A initialization
    // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
    DDRA = (0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
    // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
    PORTA = (0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);

    // Port B initialization
    // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
    DDRB = (0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
    // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
    PORTB = (0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);

    // Port C initialization
    // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=In Bit2=Out Bit1=Out Bit0=Out 
    DDRC = (1<<DDC7) | (1<<DDC6) | (1<<DDC5) | (1<<DDC4) | (0<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
    // State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=T Bit2=0 Bit1=0 Bit0=0 
    PORTC = (0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);

    // Port D initialization
    // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
    DDRD = (0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
    // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
    PORTD = (0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);

    // Timer/Counter 0 initialization
    // Clock source: System Clock
    // Clock value: Timer 0 Stopped
    // Mode: Normal top=0xFF
    // OC0 output: Disconnected
    TCCR0 = (0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (0<<CS01) | (0<<CS00);
    TCNT0 = 0x00;
    OCR0 = 0x00;

    // Timer/Counter 1 initialization
    // Clock source: System Clock
    // Clock value: Timer1 Stopped
    // Mode: Normal top=0xFFFF
    // OC1A output: Disconnected
    // OC1B output: Disconnected
    // Noise Canceler: Off
    // Input Capture on Falling Edge
    // Timer1 Overflow Interrupt: Off
    // Input Capture Interrupt: Off
    // Compare A Match Interrupt: Off
    // Compare B Match Interrupt: Off
    TCCR1A = (0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
    TCCR1B = (0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
    TCNT1H = 0x00;
    TCNT1L = 0x00;
    ICR1H = 0x00;
    ICR1L = 0x00;
    OCR1AH = 0x00;
    OCR1AL = 0x00;
    OCR1BH = 0x00;
    OCR1BL = 0x00;

    // Timer/Counter 2 initialization
    // Clock source: System Clock
    // Clock value: Timer2 Stopped
    // Mode: Normal top=0xFF
    // OC2 output: Disconnected
    ASSR = 0<<AS2;
    TCCR2 = (0<<PWM2) | (0<<COM21) | (0<<COM20) | (0<<CTC2) | (0<<CS22) | (0<<CS21) | (0<<CS20);
    TCNT2 = 0x00;
    OCR2 = 0x00;

    // Timer(s)/Counter(s) Interrupt(s) initialization
    TIMSK = (0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);

    // External Interrupt(s) initialization
    // INT0: Off
    // INT1: Off
    // INT2: Off
    MCUCR = (0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
    MCUCSR = (0<<ISC2);

    // USART initialization
    // USART disabled
    UCSRB = (0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (0<<RXEN) | (0<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);

    // Analog Comparator initialization
    // Analog Comparator: Off
    // The Analog Comparator's positive input is
    // connected to the AIN0 pin
    // The Analog Comparator's negative input is
    // connected to the AIN1 pin
    ACSR = (1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);

    // ADC initialization
    // ADC Clock frequency: 125.000 kHz
    // ADC Voltage Reference: Int., cap. on AREF
    // ADC Auto Trigger Source: ADC Stopped
    ADMUX = ADC_VREF_TYPE;
    ADCSRA = (1<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (1<<ADPS2) | (1<<ADPS1) | (0<<ADPS0);
    SFIOR = (0<<ADTS2) | (0<<ADTS1) | (0<<ADTS0);

    // SPI initialization
    // SPI disabled
    SPCR = (0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);

    // TWI initialization
    // TWI disabled
    TWCR = (0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);

    // Alphanumeric LCD initialization
    // Connections are specified in the
    // Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
    // RS - PORTC Bit 0
    // RD - PORTC Bit 1
    // EN - PORTC Bit 2
    // D4 - PORTC Bit 4
    // D5 - PORTC Bit 5
    // D6 - PORTC Bit 6
    // D7 - PORTC Bit 7
    // Characters/line: 16
    lcd_init(16);

    PORTC = 0x00;
    DDRC = 0xF7;
    ADMUX = ADC_VREF_TYPE & 0xff;
    ADCSRA = 0x83;

    DDRD = 0xf8;
    PORTD = 0xf8;
    DDRB = 0xff;
    PORTB = 0xf8;
    DDRA.3 = 1;
    DDRA.4 = 1;
    DDRA.5 = 1;
    DDRA.6 = 1;

    DDRA.7 = 1;
    DDRD.7 = 1;
    DDRC.3 = 1;

    while (1){

        // analog signals input
        temp = read_adc(0);
        light = read_adc(1);
        distance = read_adc(2);

        key=keyboard(); // keypad input
    
        //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= handle keypad input:
        if (key != 20){ 
            if (key == 7 || key == 8 || key == 9) {backupFlag = flag;}
            
            flag = key;
            
            lcd_gotoxy(0, 0);
            lcd_puts("                        ");
            lcd_gotoxy(0, 1);
            lcd_puts("                        ");    
            
            PORTB = 0x00;
            PORTA.3 = 0;
            PORTA.4 = 0;
            PORTA.5 = 0;
            PORTA.6 = 0;
            
            // update 7-segments
            if (key == 1) { PORTA.6 = 1;}  
            else if (key == 2) {PORTA.5 = 1;}
            else if (key == 3) {PORTA.5 = 1; PORTA.6 = 1;}
            else if (key == 4) {PORTA.4 = 1;}
            else if (key == 5) {PORTA.4 = 1; PORTA.6 = 1;}
            else if (key == 6) {PORTA.4 = 1; PORTA.5 = 1;}
            else if (key == 7) {PORTA.4 = 1; PORTA.5 = 1; PORTA.6 = 1;}
            else if (key == 8) {PORTA.3 = 1;}
            else if (key == 9) {PORTA.3 = 1; PORTA.6 = 1;}
        }
        
        //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= handle LCD:
        if (flag == 10 || flag == 0){        
            sprintf(s, " Use      ");
            lcd_gotoxy(x, 0);
            lcd_puts(s); 
            sprintf(s, " KeyPad   ");
            lcd_gotoxy(x, 1);
            lcd_puts(s);
        } //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        else if(flag == 1){
            if( temp/4 > 49){
                sprintf(s, " Temp(C)  ");
                lcd_gotoxy(x, 0);
                lcd_puts(s);
                sprintf(s, " >50C     ");
                lcd_gotoxy(x, 1);
                lcd_puts(s);
            }
            else{   
                sprintf(s, " Temp(C)  ");
                lcd_gotoxy(x, 0);
                lcd_puts(s);
                sprintf(s, " %dC      ", temp/4);
                lcd_gotoxy(x, 1);
                lcd_puts(s);
                }
                PORTB.2 = 1;
        } //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        else if(flag == 2){
            if( temp/4 > 49){  
                sprintf(s, " Temp(F)  ");
                lcd_gotoxy(x, 0);
                lcd_puts(s);
                sprintf(s, " >122F    ");
                lcd_gotoxy(x, 1);
                lcd_puts(s);
            }
            else{
                sprintf(s, " Temp(F)  ");
                lcd_gotoxy(x, 0);
                lcd_puts(s);
                sprintf(s, " %dF      ", ((temp/4)*(9))/5 + 32);
                lcd_gotoxy(x, 1);
                lcd_puts(s);
            }
            PORTB.2 = 1;
        } //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        else if(flag == 3){
            if( temp/4 > 49){
                sprintf(s, " Temp(K)  ");
                lcd_gotoxy(x, 0);
                lcd_puts(s);
                sprintf(s, " >323K    ");
                lcd_gotoxy(x, 1);
                lcd_puts(s);
            }
            else{
                sprintf(s, " Temp(K)  ");
                lcd_gotoxy(x, 0);
                lcd_puts(s);
                sprintf(s, " %dK      ", (temp/4) + 273);
                lcd_gotoxy(x, 1);
                lcd_puts(s);
            }
            PORTB.2=1;
        } //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        else if(flag == 4){
            if( light/6 > 32){
                sprintf(s, " Light    ");
                lcd_gotoxy(x, 0);
                lcd_puts(s);
                sprintf(s, " >33uW/cm2 ");
                lcd_gotoxy(x, 1);
                lcd_puts(s);
            }
            else{
                sprintf(s, " Light    ");
                lcd_gotoxy(x, 0);
                lcd_puts(s);
                sprintf(s, " %duW/cm2 ", light/6);
                lcd_gotoxy(x, 1);
                lcd_puts(s);
            }
            PORTB.1 = 1;
        } //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        else if(flag == 5){        
            if ( 161 - distance/2 < 65){
                sprintf(s, " Dist.    ");
                lcd_gotoxy(x, 0);
                lcd_puts(s);
                sprintf(s, " <65cm     ");
                lcd_gotoxy(x, 1);
                lcd_puts(s);
            }
            else{
                sprintf(s," Dist.    ");
                lcd_gotoxy(x, 0);
                lcd_puts(s);
                sprintf(s, " %dcm      ", 161 - distance/2);
                lcd_gotoxy(x, 1);
                lcd_puts(s);
            }
            PORTB.0 = 1; 
        } //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        else if(flag == 6){
            if ( 161 - distance/2 < 65){
                sprintf(s, " Dist.    ");
                lcd_gotoxy(x, 0);
                lcd_puts(s);
                sprintf(s, " <165inch ");
                lcd_gotoxy(x, 1);
                lcd_puts(s);            
            }
            else{
            sprintf(s, " Dist.    ");
            lcd_gotoxy(x, 0);
            lcd_puts(s);
            sprintf(s, " %dinch    ", ((161 - distance/2)*254)/100 );
            lcd_gotoxy(x, 1);
            lcd_puts(s);    
            }
            PORTB.0 = 1;
        } //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        else if(flag == 7){
            doLEDanimate=1;
            flag = backupFlag;  
        } //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=  
        else if (key == 8){
            doAnimate = 1;
            flag = backupFlag;           
        } //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        else if (key == 9){
            doAnimate = 0;
            doLEDanimate = 0;
            flag = backupFlag;
        }

        //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= handle LCD animation
        if (doAnimate == 1){
            lcd_gotoxy(x, y);
            lcd_puts(" ");
            x += direction; // Update x position
            // Check collision with screen edges
            if (x >= LCD_WIDTH-7){
                x = LCD_WIDTH-7 - 1; // Adjust x to prevent overflow
                direction = -1; // Change direction to left
            }
            else if (x < 0){
                x = 0; // Adjust x to prevent underflow
                direction = 1; // Change direction to right
            }

            if (y == 0) y = 1;
            else y = 0;
        }

        //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= handle LEDs animation
        if (doLEDanimate==1){
            PORTB.3 = rand() % 2;
            PORTB.4 = rand() % 2;
            PORTB.5 = rand() % 2;
            PORTB.6 = rand() % 2;
            PORTB.7 = rand() % 2;  
        }

        //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= handle critical situation:
        if(161 - distance/2 < 70) {PORTD.7 = ~PORTD.7;}
        else {PORTD.7 = 0;}
        
        if(temp/4 > 45) {PORTA.7 = ~PORTA.7;}
        else {PORTA.7 = 0;}
        
        if(light/6 > 30) {PORTC.3 = ~PORTC.3;}
        else { PORTC.3 = 0;}
    


    } //while(){}



} //main(){}