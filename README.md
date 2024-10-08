# Digital Timer Using 8051 Microcontroller

This repository contains the project for the **Microprocessors and Embedded Systems** course (SEL0614/SEL0433), focusing on developing a digital timer using Assembly language on the 8051 microcontroller simulator (EdSim51).

## Project Overview

The goal of this project is to implement a digital timer that:
- Displays numbers from 0 to 9 on a 7-segment display in a loop.
- Provides two timing intervals controlled by switches:
  - **0.25-second intervals** using SW0.
  - **1-second intervals** using SW1.
- Allows toggling between timing modes by pressing the switches.
- Starts counting only when a switch is pressed, keeping the display off otherwise.

## Features
- **Assembly Code:** Written in Assembly for the 8051 microcontroller, using the EdSim51 simulator.
- **Switch Control:** Two switches (SW0 and SW1) are used to control the timer's counting intervals.
- **Timing Control:** The program changes the display interval between 0.25s and 1s depending on the switch pressed.
- **Modular Design:** Uses subroutines for delay handling and switch event detection.
- **I/O Interface:** Interacts with external inputs (buttons) and outputs (LEDs, 7-segment display).

## How to Run
1. Load the Assembly code into the EdSim51 simulator.
2. Use the available switches to toggle between the different timer intervals.
3. Observe the 7-segment display for the countdown loop.

## Files Included
- `timer.asm`: The Assembly source code for the 8051 microcontroller.
- Documentation including:
  - A schematic diagram of the microcontroller and its connections.
  - A table explaining how the 7-segment display is controlled using the port registers.
  
## Diagram
- A schematic of the 8051 microcontroller with its I/O interfaces and display connections.

## Requirements
- EdSim51 simulator.
