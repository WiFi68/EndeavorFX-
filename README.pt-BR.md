# EndeavorFX

**Iluminação cinemática adaptativa para Roblox Studio.**

Analise a cena. Entenda o plano. Melhore a imagem.

EndeavorFX é um sistema de iluminação em Lua, gratuito e de código aberto, que analisa a cena atual e a câmera ativa para construir uma solução de iluminação cinemática ao redor do plano.

**Não existe um plugin oficial.**

EndeavorFX é um sistema autossuficiente para a **Command Bar**. Copie o código, cole na Command Bar do Roblox Studio e execute.

«Construído por WiFi. Melhorado por todos.»

---

## ✨ Recursos

**EndeavorFX V9 inclui:**

* 🎥 **Análise do Plano** — Analisa a câmera ativa, composição do viewport, conteúdo visível da cena, importância em espaço de tela e características do plano.

* 🧠 **Iluminação Adaptativa** — Avalia luminância, cor, materiais, iluminação existente e composição da cena para calcular uma solução de iluminação cinemática.

* 🎯 **Foco Automático Multi-Ray** — Usa múltiplos raios da câmera para estimar uma distância de foco mais estável em vez de depender de um único raio central.

* 💡 **Análise de Luzes Existentes** — Analisa PointLights, SpotLights e SurfaceLights existentes e incorpora sua contribuição à solução.

* 🧱 **Consciência de Materiais** — Considera materiais relevantes, incluindo Metal, Glass e superfícies Neon/emissivas.

* 🌅 **Análise do Sol e Luz Chave** — Considera a direção do sol e as fontes de luz existentes ao resolver o plano.

* 🏠 **Consciência Interior / Exterior** — Usa visibilidade do céu e heurísticas de encerramento da cena para determinar o contexto de iluminação.

* 🌫️ **Solucionador de Atmosfera** — Calcula dinamicamente as configurações atmosféricas a partir do humor, hora do dia e condições analisadas da cena.

* 🎨 **Pós-Processamento Cinemático** — Suporta Bloom, Color Correction, Depth of Field, Sun Rays e Color Grading.

* 🎞️ **Tonemapping** — Usa o ColorGradingEffect do Roblox com uma configuração de tonemapper compatível.

* 🌅 **Predefinições de Hora do Dia** — Dawn, Morning, Noon, GoldenHour, Dusk, Night e Studio.

* 🎭 **Predefinições de Humor** — Cinematic, GoldenHour, Studio, Dreamy, Horror, Neon e Night.

* ⚙️ **Modos de Qualidade** — Showcase, Cinematic e Balanced. A qualidade determina quanto de análise de cena é realizado.

* 💾 **Backup Automático** — Cria um snapshot protegido da configuração original de Lighting antes de modificá-la.

---

## 🚀 Começando

### Roblox Studio

1. Abra seu projeto no Roblox Studio.
2. Abra a **Command Bar**.
3. Abra `src/EndeavorFX.lua` deste repositório.
4. Copie o script inteiro.
5. Cole na Command Bar.
6. Edite as quatro configurações no topo, se desejar.
7. Execute o script.

É isso.

* **Sem instalação de plugin.**
* **Sem aplicação externa.**
* **Sem software pago.**
* **Apenas Lua.**

EndeavorFX analisa o plano atual, resolve a iluminação, aplica o resultado e termina.

Ele **não** fica executando continuamente em segundo plano.

---

## ⚙️ Configuração

EndeavorFX expõe intencionalmente apenas quatro configurações para o usuário:

```lua
local QUALITY = "Showcase"
local MOOD = "Cinematic"
local TIME_OF_DAY = "Morning"
local CONTROL_TIME = true
```

Essas são as únicas configurações que a maioria dos usuários precisa alterar.

### QUALITY

Controla quanto de análise de cena é realizado.

* **Showcase** — Análise máxima. Usa mais amostras de cena, luzes e análise da câmera para obter o resultado mais completo.
* **Cinematic** — Equilíbrio entre análise e desempenho. Recomendado para a maioria das cenas.
* **Balanced** — Análise mais rápida e leve para máquinas mais lentas ou cenas complexas.

Qualidade maior não significa diretamente "gráficos melhores".

Significa **mais análise antes de calcular a solução de iluminação**.

### MOOD

Define a estética cinematográfica geral.

* **Cinematic** — Iluminação cinematográfica neutra e equilibrada.
* **GoldenHour** — Iluminação quente e dourada.
* **Studio** — Iluminação limpa e controlada de estúdio.
* **Dreamy** — Iluminação suave, clara e atmosférica.
* **Horror** — Iluminação escura, dessaturada e opressiva.
* **Neon** — Iluminação saturada, brilhante e elétrica.
* **Night** — Iluminação fria e escura de noite.

### TIME_OF_DAY

Define a hora do dia simulada pelo solucionador.

Predefinições disponíveis:

* **Dawn**
* **Morning**
* **Noon**
* **GoldenHour**
* **Dusk**
* **Night**
* **Studio**

### CONTROL_TIME

Controla se o EndeavorFX altera o `Lighting.ClockTime`.

```lua
local CONTROL_TIME = true
```

* `true` — O EndeavorFX define o `ClockTime` de acordo com o `TIME_OF_DAY`.
* `false` — O EndeavorFX mantém o `ClockTime` existente.

---

## 🎥 Como Funciona

O EndeavorFX V9 é um **solucionador heurístico de iluminação de plano único**.

```text
ANÁLISE DA CÂMERA
         ↓
ANÁLISE DA CENA
         ↓
ANÁLISE DAS LUZES
         ↓
ANÁLISE DO SOL / CÉU
         ↓
SOLUCIONADOR DO PLANO
         ↓
APLICAÇÃO DA ILUMINAÇÃO
         ↓
PÓS-PROCESSAMENTO
         ↓
PRONTO
```

### Pipeline

#### 1. Análise da Câmera

O EndeavorFX analisa a câmera ativa, composição do viewport, geometria visível, importância em espaço de tela e distância de foco.

A análise de foco multi-ray ajuda a produzir um alvo de profundidade de campo mais estável do que um único raio central.

#### 2. Análise da Cena

O conteúdo visível da cena é amostrado dentro da visão da câmera.

O solucionador considera:

* Luminância da cena
* Cor
* Saturação
* Calor
* Importância em espaço de tela
* Materiais
* Objetos visíveis grandes
* Metal
* Glass
* Superfícies Neon/emissivas
* Encerramento da cena
* Visibilidade do céu

#### 3. Análise das Luzes

Instâncias `PointLight`, `SpotLight` e `SurfaceLight` existentes são analisadas.

Sua contribuição é incorporada à solução em vez de simplesmente ser ignorada.

#### 4. Análise do Sol e do Céu

O solucionador analisa a visibilidade do céu e a direção do sol.

Isso ajuda a determinar se o plano se comporta mais como um ambiente externo, parcialmente fechado ou interno.

#### 5. Solucionador do Plano

Os dados analisados são combinados com o **Quality**, **Mood** e **Time of Day** selecionados.

O solucionador calcula valores como:

* Compensação de exposição
* Iluminação ambiente
* Iluminação ambiente externa
* Deslocamento de cor
* Matiz da iluminação
* Bloom
* Sun rays
* Depth of field
* Atmosfera
* Distância de foco

#### 6. Aplicação

A solução calculada é aplicada ao Lighting do Roblox e aos efeitos de pós-processamento necessários.

Depois que o plano é resolvido, o script termina.

---

## 🎭 Predefinições de Humor

Cada humor fornece uma estética inicial diferente.

| Humor          | Descrição                                       |
| -------------- | ----------------------------------------------- |
| **Cinematic**  | Iluminação cinematográfica neutra e equilibrada |
| **GoldenHour** | Luz solar quente e saturada                     |
| **Studio**     | Iluminação limpa e brilhante                    |
| **Dreamy**     | Iluminação suave e atmosférica                  |
| **Horror**     | Iluminação escura, dessaturada e opressiva      |
| **Neon**       | Iluminação saturada, brilhante e elétrica       |
| **Night**      | Iluminação fria e noturna                       |

O humor não substitui completamente a cena.

Ele funciona como uma **estética-alvo** que o solucionador adapta ao plano analisado.

---

## 🌅 Hora do Dia

As predefinições disponíveis são:

| Predefinição   | ClockTime | Característica Geral                   |
| -------------- | --------: | -------------------------------------- |
| **Dawn**       |       6.2 | Início da manhã, transição quente/fria |
| **Morning**    |       9.0 | Luz clara da manhã                     |
| **Noon**       |      12.5 | Luz diurna forte                       |
| **GoldenHour** |      17.2 | Luz quente do fim da tarde             |
| **Dusk**       |      18.4 | Luz de transição do início da noite    |
| **Night**      |      22.0 | Iluminação noturna fria                |
| **Studio**     |      12.0 | Luz diurna neutra de estúdio           |

`CONTROL_TIME = false` impede que o EndeavorFX altere o `ClockTime`.

---

## ⚙️ Modos de Qualidade

A qualidade controla a **profundidade da análise**, não uma configuração direta de gráficos.

### Showcase

Análise máxima.

* 900 partes
* 260 luzes
* 15 amostras de frustum
* 9 raios de foco
* 12 raios de céu

Ideal para cenas detalhadas de showcase quando um pouco mais de tempo de análise é aceitável.

### Cinematic

Análise equilibrada.

* 650 partes
* 180 luzes
* 11 amostras de frustum
* 7 raios de foco
* 10 raios de céu

Recomendado para a maioria das cenas.

### Balanced

Análise leve.

* 400 partes
* 120 luzes
* 7 amostras de frustum
* 5 raios de foco
* 8 raios de céu

Útil para cenas complexas ou máquinas de desenvolvimento mais lentas.

---

## 💾 Backup Automático

Antes de modificar o Lighting, o EndeavorFX cria um snapshot em:

```text
Lighting.G_EndeavorFX_BACKUP
```

O backup contém a configuração original do Lighting e cópias da atmosfera e dos efeitos de pós-processamento relevantes.

Se o EndeavorFX for executado várias vezes, o backup existente é reutilizado em vez de criar um novo snapshot a cada execução.

Isso permite experimentar diferentes configurações mantendo o estado original protegido.

O backup pode ser excluído manualmente quando não for mais necessário.

---

## 🧪 Código Aberto

EndeavorFX é intencionalmente de código aberto.

Você pode:

* **Fazer um fork do projeto**
* **Modificar o solucionador**
* **Criar humores personalizados**
* **Criar predefinições de horário personalizadas**
* **Experimentar com os algoritmos de análise**
* **Otimizar o desempenho**
* **Corrigir bugs**
* **Construir suas próprias ferramentas ao redor do EndeavorFX**

Você não precisa esperar o projeto principal dar suporte à sua ideia.

**Faça sua própria versão.**

Quer criar:

> «EndeavorFX Ultra Mega Blender Quality Lighting Extreme»

**Vá em frente.**

Quer criar uma versão pequena focada em desempenho?

**Vá em frente.**

Quer reescrever completamente o solucionador de iluminação?

**Vá em frente.**

É para isso que existe o código aberto.

---

## 🤝 Contribuindo

Encontrou um bug?

Tem uma otimização?

Melhorou o solucionador?

Adicionou um recurso útil?

**Abra uma issue ou pull request.**

Melhorias úteis podem eventualmente fazer parte da base de código principal do EndeavorFX.

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

O V9 realiza análise heurística da cena e produz uma **solução de iluminação de plano único**.

Ele não é fisicamente preciso e não tenta simular perfeitamente a iluminação do mundo real.

### Espere

* Recursos experimentais
* Algoritmos em mudança
* Melhorias de desempenho
* Novas predefinições
* Correções de bugs
* Iluminação ocasional que faz você questionar suas escolhas de vida 💀

### Limitações Conhecidas

* A análise da cena é heurística, não baseada em física.
* A iluminação não é fisicamente precisa.
* Os resultados podem variar entre cenas.
* O desempenho depende da complexidade da cena e da qualidade selecionada.
* Cenas complexas podem exigir mais tempo de análise.
* Os algoritmos podem mudar entre versões.

Se algo não se comportar corretamente, reporte através das **GitHub Issues**.

---

## 📜 Licença

EndeavorFX é lançado sob a **Licença MIT**.

Consulte `LICENSE` para o texto completo da licença.

Você é livre para usar, modificar e distribuir o EndeavorFX para qualquer finalidade permitida pela Licença MIT.

---

## 💭 Filosofia

EndeavorFX não foi feito para decidir como seu jogo deve parecer.

Ele foi feito para fornecer um ponto de partida forte.

**Analise a cena.**

**Resolva o plano.**

**Depois faça-o seu.**

— WiFi

---

## 🌐 Idiomas

[**English**](./README.md) | [**Português (Brasil)**](./README.pt-BR.md)
