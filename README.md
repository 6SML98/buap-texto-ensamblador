# Texto en ensamblador

Programa DOS en ensamblador x86 que recibe texto y lo muestra junto con un reloj.

## Requisitos

MASM 5.10, LINK para DOS y DOSBox.

## Ejecutar

En DOSBox, monta la carpeta del proyecto como C:, copia tus herramientas MASM y LINK y ejecuta:

```text
masm PF.asm;
link PF.obj;
PF.exe
```

## Verificación del 8 de octubre de 2026

Se ensambló y enlazó con cero errores en DOSBox Staging. La interacción con el teclado y el movimiento de texto no se probaron. No ejecuta directamente como programa Windows de 64 bits.
