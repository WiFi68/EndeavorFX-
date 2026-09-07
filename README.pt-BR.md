# EndeavorFX

**Iluminação cinemática adaptativa para Roblox Studio.**

Analise a cena. Entenda o plano. Melhore a imagem.

EndeavorFX é um sistema de iluminação Lua livre e de código aberto para Roblox, projetado para analisar uma cena e construir automaticamente uma configuração de iluminação cinemática ao redor da câmera ativa.

**Não há plugin oficial.** EndeavorFX é um sistema Lua autossuficiente da Command Bar. Copie o código, cole na Command Bar e execute.

«Construído por WiFi. Melhorado por todos.»

---

## ✨ Recursos

**V9 implementa:**

- 🎥 **Análise de Plano** — Analisa a câmera ativa, composição, conteúdo da cena visível, importância em espaço de tela e características do plano.

- 🧠 **Iluminação Adaptativa** — Analisa luminância da cena, cor, materiais, iluminação existente e composição para determinar uma solução de iluminação cinemática apropriada.

- 🎯 **Foco Automático Multi-Ray** — Usa múltiplos raios de câmera para estimar uma distância de foco mais estável em vez de confiar em um único raio central.

- 💡 **Análise de Luzes Existentes** — Analisa PointLights, SpotLights e SurfaceLights existentes e incorpora sua contribuição à solução de iluminação.

- 🧱 **Consciência de Materiais** — Considera características relevantes de materiais, incluindo Metal, Glass e superfícies Neon/emissivas.

- 🌅 **Análise de Sol / Luz Chave** — Considera a direção do sol da cena e a iluminação existente ao resolver o plano.

- 🏠 **Consciência Interior / Exterior** — Usa heurísticas de encerramento de cena e visibilidade do céu para distinguir entre diferentes contextos de iluminação.

- 🌫️ **Solucionador de Atmosfera** — Determina dinamicamente configurações atmosféricas com base no humor, hora do dia, condições da cena e plano resolvido.

- 🎨 **Pós-Processamento Cinemático** — Suporta Bloom, Color Correction, Depth of Field, Sun Rays e Color Grading.

- 🎞️ **Color Grading** — Usa ColorGradingEffect do Roblox e configuração apropriada do tonemapper quando suportado.

- 🌅 **Predefinições de Hora do Dia** — Dawn, Morning, Noon, GoldenHour, Dusk, Night e Studio.

- 🎭 **Predefinições de Humor** — Cinematic, GoldenHour, Studio, Dreamy, Horror, Neon e Night.

- ⚙️ **Modos de Qualidade** — Showcase, Cinematic e Balanced. Qualidade controla quanto de análise é realizado internamente.

- 💾 **Backup e Restauração** — Protege a configuração de iluminação original antes de EndeavorFX modificá-la.

---

## 🚀 Começando

### Roblox Studio

1. Abra seu projeto do Roblox Studio.
2. Abra a **Command Bar**.
3. Abra `src/EndeavorFX.lua` neste repositório.
4. Copie o código inteiro.
5. Cole na Command Bar.
6. Edite as quatro configurações de usuário no topo, se desejar:
   - `QUALITY`
   - `MOOD`
   - `TIME_OF_DAY`
   - `CONTROL_TIME`
7. Execute o script.

É isso.

- **Sem instalação de plugin.**
- **Sem aplicação externa.**
- **Sem software pago.**
- **Apenas Lua.**

---

## ⚙️ Configuração

EndeavorFX expõe quatro configurações visíveis para o usuário:

```lua
local QUALITY = "Showcase"      -- Showcase, Cinematic ou Balanced
local MOOD = "Cinematic"        -- Cinematic, GoldenHour, Studio, Dreamy, Horror, Neon ou Night
local TIME_OF_DAY = "Morning"   -- Dawn, Morning, Noon, GoldenHour, Dusk, Night ou Studio
local CONTROL_TIME = true       -- true para atualizar ClockTime, false para deixá-lo inalterado
```

### QUALITY

Controla quanto de análise de cena é realizado:

- **Showcase** — Qualidade máxima. Analisa mais partes, luzes e amostras de viewport para o resultado de qualidade mais alta. Use quando o desempenho não é uma preocupação.
- **Cinematic** — Qualidade equilibrada. Boa análise com desempenho razoável. Recomendado para a maioria dos casos.
- **Balanced** — Análise rápida. Varredura de cena mais leve para melhor desempenho em máquinas lentas ou cenas complexas.

### MOOD

Define o tom emocional e a estética de iluminação:

- **Cinematic** — Iluminação cinemática profissional e neutra.
- **GoldenHour** — Estética quente e dourada ao sol.
- **Studio** — Iluminação de estúdio limpa e brilhante.
- **Dreamy** — Aparência suave, etérea e super saturada.
- **Horror** — Atmosfera sombria, dessaturada e ominosa.
- **Neon** — Alta saturação, sintético elétrico.
- **Night** — Iluminação fresca e noturna.

### TIME_OF_DAY

Controla o ângulo do sol, cor do céu e matiz atmosférico:

- **Dawn** — Início da manhã, luz fresca.
- **Morning** — Meio da manhã, luz clara.
- **Noon** — Meio-dia, sol em cima.
- **GoldenHour** — Final da tarde, luz dourada quente.
- **Dusk** — Início da noite, luz roxa transitória.
- **Night** — Noturno, escuridão azul fresca.
- **Studio** — Meio-dia neutro (não altera ClockTime se CONTROL_TIME for falso).

### CONTROL_TIME

Se `true`, EndeavorFX define Lighting.ClockTime para corresponder à predefinição TIME_OF_DAY. Se `false`, o ClockTime é deixado inalterado.

---

## 🎥 Como Funciona

EndeavorFX opera como um solucionador heurístico de um único plano:

```
ANÁLISE DE CÂMERA
    ↓
ANÁLISE DE CENA
    ↓
ANÁLISE DE LUZES
    ↓
SOLUCIONADOR DE PLANO
    ↓
APLICAÇÃO DE ILUMINAÇÃO
    ↓
PÓS-PROCESSAMENTO
    ↓
PRONTO
```

### Pipeline

1. **Análise de Câmera** — Analisa a câmera ativa, composição do viewport e distância de foco multi-ray.

2. **Análise de Cena** — Varre partes visíveis dentro do frustum da câmera. Analisa cores, materiais (Metal, Glass, Neon), saturação e calor. Computa pesos de composição em espaço de tela.

3. **Análise de Luzes** — Analisa PointLights, SpotLights e SurfaceLights existentes. Computa sua contribuição de energia, brilho e calor.

4. **Análise de Céu e Sol** — Determina visibilidade do céu e alinhamento da direção do sol. Estima contexto interior vs. exterior.

5. **Solucionador de Plano** — Combina todos os dados de análise com o Humor e Hora do Dia selecionados para computar:
   - Compensação de exposição
   - Cor ambiente
   - Cor ambiente externa
   - Deslocamento de cor e matiz
   - Intensidade de bloom
   - Intensidade de raios solares
   - Parâmetros de profundidade de campo
   - Densidade de atmosfera

6. **Aplicação** — Aplica a solução à Iluminação e cria/atualiza efeitos de pós-processamento.

### Filosofia de Design

EndeavorFX é **heurístico**, não fisicamente preciso. Usa regras e heurísticas para fazer suposições educadas sobre as necessidades de iluminação da cena. Os resultados podem variar por cena, e os algoritmos podem mudar entre versões.

O sistema é projetado para produzir um **ponto de partida cinemático forte** em vez de fotorrealismo perfeito.

---

## 🎭 Predefinições de Humor

Cada humor define uma estética única com intensidades específicas de exposição, cor, atmosfera e efeitos:

- **Cinematic** — Profissional, neutro, equilibrado para uso geral.
- **GoldenHour** — Quente, saturado, bloom brilhante e raios solares.
- **Studio** — Limpo, brilhante, efeitos atmosféricos mínimos.
- **Dreamy** — Macio, super saturado, bloom pesado e neblina.
- **Horror** — Escuro, dessaturado, bloom mínimo, atmosfera opressiva.
- **Neon** — Alta saturação, bloom alto, atmosfera elétrica.
- **Night** — Fresco, escuro, atmosfera e bloom moderados.

---

## 🌅 Hora do Dia

As predefinições de Hora do Dia controlam o ClockTime do sol e o matiz da iluminação:

| Predefinição | ClockTime | Matiz                   |
|------------|-----------|-------------------------|
| Dawn       | 6.2       | Laranja quente (nascer) |
| Morning    | 9.0       | Branco neutro           |
| Noon       | 12.5      | Branco brilhante        |
| GoldenHour | 17.2      | Laranja dourado quente  |
| Dusk       | 18.4      | Roxo fresco             |
| Night      | 22.0      | Azul fresco             |
| Studio     | 12.0      | Branco neutro           |

---

## ⚙️ Modos de Qualidade

Qualidade mais alta não significa "gráficos melhores." Significa análise de cena mais completa:

- **Showcase** — 900 partes, 260 luzes, 15 amostras de frustum, 9 raios de foco, 12 raios de céu.
- **Cinematic** — 650 partes, 180 luzes, 11 amostras de frustum, 7 raios de foco, 10 raios de céu.
- **Balanced** — 400 partes, 120 luzes, 7 amostras de frustum, 5 raios de foco, 8 raios de céu.

Escolha **Showcase** para cenas complexas e detalhadas onde deseja análise máxima.

Escolha **Cinematic** para desempenho equilibrado e qualidade.

Escolha **Balanced** para análise rápida em máquinas lentas ou cenas muito complexas.

---

## 💾 Backup e Restauração

Quando EndeavorFX é executado, cria automaticamente um backup da configuração original de Iluminação em:

```
Lighting.G_EndeavorFX_BACKUP
```

Isso inclui:
- Propriedades originais de Iluminação (Ambient, Exposure, etc.)
- Efeitos de pós-processamento originais (Bloom, DOF, ColorCorrection, etc.)
- Atmosfera original (se presente)

Se você executar EndeavorFX várias vezes, reutiliza o mesmo backup (não cria duplicatas).

O backup é seguro para deletar manualmente a qualquer momento.

---

## 🧪 Código Aberto

EndeavorFX é intencionalmente de código aberto.

Você pode:

- **Fazer um fork do projeto** — Criar sua própria versão.
- **Modificar o solucionador** — Mudar como a iluminação é computada.
- **Criar predefinições** — Adicionar humores e horários personalizados.
- **Experimentar com algoritmos** — Testar novas abordagens.
- **Otimizar para desempenho** — Fazer mais rápido.
- **Corrigir bugs** — Melhorar estabilidade.
- **Construir ferramentas** — Criar plugins, exportadores ou integrações ao redor do EndeavorFX.

Você não precisa esperar que o projeto principal suporte sua ideia.

**Faça sua própria versão.**

Quer criar:

«EndeavorFX Ultra Mega Blender Quality Lighting Extreme»

**Vá em frente.**

Quer criar uma versão pequena otimizada para desempenho?

**Vá em frente.**

Quer reescrever completamente o solucionador de iluminação?

**Vá em frente.**

É para isso que existe o código aberto.

---

## 🤝 Contribuindo

Encontrou um bug? Tem uma otimização? Melhorou o solucionador? Adicionou um recurso útil?

**Abra uma issue ou pull request.**

Se suas alterações forem úteis para o projeto, elas podem se tornar parte da base de código principal do EndeavorFX.

Seu fork também pode permanecer completamente independente.

---

## 🌐 A Comunidade

**Bem-vindo, Wifilings. 📶**

Wifilings são a comunidade ao redor do EndeavorFX e dos projetos construídos a partir dele.

Se você está usando o código original, modificando-o, criando um fork ou construindo algo completamente ridículo com ele—

**você faz parte da comunidade.**

---

## ⚠️ Status Atual

**EndeavorFX V9 é um solucionador de iluminação cinemática experimental em evolução.**

O solucionador de plano V9 realiza análise de cena heurística e produz uma solução de iluminação de um único plano. Não é fisicamente preciso.

**Espere:**

- Recursos experimentais
- Algoritmos em mudança
- Melhorias de desempenho
- Novas predefinições
- Correções de bugs
- Iluminação ocasional que faz você questionar suas escolhas de vida 💀

**Limitações conhecidas:**

- Análise de cena é heurística, não baseada em física.
- Iluminação não é fisicamente precisa.
- Resultados podem variar significativamente por cena.
- Desempenho depende da complexidade da cena e configuração de qualidade.
- Algoritmos podem mudar entre versões.

Se algo não se comportar corretamente, reporte através de [GitHub Issues](https://github.com/WiFi68/EndeavorFX-/issues).

---

## 📜 Licença

EndeavorFX é lançado sob a **Licença MIT**.

Veja [LICENSE](./LICENSE) para o texto completo da licença.

Você é livre para usar, modificar e distribuir EndeavorFX para qualquer propósito.

---

## 💭 Filosofia

EndeavorFX não foi feito para decidir como seu jogo deve parecer.

Foi feito para lhe dar um ponto de partida forte.

**Analise a cena.**

**Resolva o plano.**

**Depois faça-o seu.**

— WiFi

---

## 🌐 Idiomas

[English](./README.md) | [Português (Brasil)](./README.pt-BR.md)
