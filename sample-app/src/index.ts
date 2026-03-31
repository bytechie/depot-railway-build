/**
 * OpenClaw Demo - Main Entry Point
 * Personal AI Assistant with Skills System
 */

import express from 'express';
import { SkillRegistry, emailSkill, calendarSkill, reminderSkill, webSearchSkill } from './skills/index.js';
import { ClaudeModel } from './ai/claude.js';
import type { Message } from './types.js';

const app = express();
const PORT = process.env.PORT || 3000;

// Initialize skills registry
const skillRegistry = new SkillRegistry();
skillRegistry.register(emailSkill);
skillRegistry.register(calendarSkill);
skillRegistry.register(reminderSkill);
skillRegistry.register(webSearchSkill);

// Initialize AI model
const aiModel = new ClaudeModel(process.env.ANTHROPIC_API_KEY || 'demo-key');

app.use(express.json());

// Health check
app.get('/health', (_req, res) => {
  res.json({
    status: 'healthy',
    service: 'OpenClaw Demo',
    version: '1.0.0',
    skills: skillRegistry.list().length,
  });
});

// List available skills
app.get('/skills', (_req, res) => {
  res.json({
    skills: skillRegistry.list().map(s => ({
      name: s.name,
      description: s.description,
    })),
  });
});

// Process message endpoint
app.post('/message', async (req, res) => {
  try {
    const message: Message = req.body;

    // Process with AI
    const aiResponse = await aiModel.processMessage(message.content);

    // Execute relevant skill
    const skillName = req.body.skill;
    let skillResult = null;
    if (skillName) {
      skillResult = await skillRegistry.execute(skillName, {
        input: message.content,
        userId: message.userId,
        timestamp: new Date(),
      });
    }

    res.json({
      success: true,
      aiResponse,
      skillResult,
      timestamp: new Date().toISOString(),
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: error instanceof Error ? error.message : 'Unknown error',
    });
  }
});

// Start server
app.listen(PORT, () => {
  console.log(`🦞 OpenClaw Demo running on port ${PORT}`);
  console.log(`📊 Skills registered: ${skillRegistry.list().length}`);
  console.log(`🤖 AI Model: ${aiModel.name}`);
  console.log('\nAvailable endpoints:');
  console.log(`  GET  /health     - Health check`);
  console.log(`  GET  /skills     - List available skills`);
  console.log(`  POST /message    - Process a message`);
});
