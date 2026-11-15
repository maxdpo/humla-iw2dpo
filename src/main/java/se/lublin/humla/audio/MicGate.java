/*
 * Copyright (C) 2026 IW2DPO
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

package se.lublin.humla.audio;

import android.os.SystemClock;

/**
 * IW2DPO: microphone gate.
 *
 * While the gate is closed, every microphone frame read by the audio input thread is
 * replaced with silence before it is encoded and transmitted. Used by the app to keep
 * the local PTT "ready to talk" beep (played on the radio loudspeaker) out of the channel.
 *
 * The gate works on the samples as they are READ, so it also silences audio that
 * Android buffered in the AudioRecord while the PTT was released (the input thread
 * pauses between transmissions but the AudioRecord keeps recording).
 *
 * Times are {@link SystemClock#uptimeMillis()}.
 */
public final class MicGate {
    private static volatile long sClosedUntil = 0;

    private MicGate() {
    }

    /** Closes the gate (mic = silence) until the given uptime, in ms. */
    public static void closeUntil(long uptimeMillis) {
        sClosedUntil = uptimeMillis;
    }

    /** Opens the gate immediately. */
    public static void open() {
        sClosedUntil = 0;
    }

    /** @return true if mic frames must be replaced with silence now. */
    public static boolean isClosed() {
        return SystemClock.uptimeMillis() < sClosedUntil;
    }
}
